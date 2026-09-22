# nix-config

This is my personal nix configuration

Using the minimal ISO for nixos, we

## Steps to install this configuration

### (Optional) Change to root user to avoid using sudo

In the installer we start with the user `nixos`, no password, no another
username, just switch to root with `sudo su root` (or `sudo su`, not other
users in the system)

### Partitionate the disk

```sh
# Verify the unit name of the disk unit
lsblk
```

This should show something like

```bash
NAME  MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
loop0   7:0    0  1.5G  1 loop /nix/.ro-store
sr0    11:0    1  1.7G  1 rom  /iso
vda   254:0    0  128G  0 disk
```

So, our disk is `vda` and should be called with `/dev/vda`

### Partition table GPT

Then we stablish a list of partitions GPT, in this way

```bash
parted /dev/vda -- mklabel gpt
```

`--` is used to pass the next argument as command, UNIX convention. `mklabel gpt` erases any partition table in the device and creates a new one with gpt (GUID Parition Table)

### Make an ESP partition

Then we define a ESP partition in the device

```bash
parted /dev/vda -- mkpart ESP fat32 1MB 512MB
parted /dev/vda -- set 1 esp on
```

`mkpart ESP fat32 1MB 512MB` creates a new partition: ESP is just a descriptive
tag (call it as you like), fat32 is the filesystem to be used (`parted`
annotates it on the table, but the formatting will happen later by using
`mkfs`), `1MB 512MB` is the space range in the disk - start in the megabyte 1
(first MB empty by alignment, standard practice) and ends in the megabyte 512,
in this way, we get 511 MB

`set 1 esp on` - marks the partition number 1 with the flag esp, this says to
the UEFI firmware "here it is the EFI System Partition, search the bootloader
here". Without this flag, the firmware does not recognizes as runnable even
with the right files.

### Creates the `root` partition

```bash
parted /dev/vda -- mkpart primary ext4 512MB 100%
```

`primary` - type of the partition (in GPT this is not necessary, but is for
compatibility)

`ext4` - again, just annotation, the real formatting comes next.

`512MB 100%` - starts just right where the ESP partition ends (megabyte 512),
and uses the rest of the disk (100%). This gonna be the number 2 partition.

### Format each partition

```bash
mkfs.fat -F32 -n boot /dev/vda1
mkfs.ext4 -L nixos /dev/vda2
```

`mkfs.fat -F32 -N boot /dev/vda1` - formats the partition 1 (ESP tagged)
as FAT32 specifically (-F32, we have FAT12/16/32 but here we need 32). -n boot
gives a tag (LABEL=boot) - this is what is gonna allow to reference the
partition by their name instead of a raw path in the next step, and this is
what NixOS uses in the `hardware-configuration` generated, so it doesn't matter
if the disk changes from `/dev/vda` to `/dev/sda` between reboots.

`mkfs.ext4 -L nixos /dev/vda2` -formats the partition 2 with the filesystem
ext4 (linux standard). `-L nixos` is the same idea, tags the partition as nixos.

### Mount the partitions where nixos

```bash
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
```

- `mount /dev/disk/by-label/nixos /mnt` - mounts the root partition (tagged as
  `nixos`) in `/mnt`. `/mnt` is the convention that awaits `nixos-install` - is
  where it "believes" it is the root `/` of the new system, besides you're in a
  live session which root is another one (the ISO itself). Use
  `/dev/disk/by-label/nixos` instead of `/dev/vda2` directly due to legibility
  and no matter if the order of the disks changes.

- `mkdir -p /mnt/boot` - as you just mounted the partition root in `/mnt`,
  still does not exist a directory called `/mnt/boot` inside of it - you create
  it to have a mounting point for ESP.
- `mount /dev/disk/by-label/boot /mnt/boot` - mounts the ESP inside the root
  partition already mounted. The order matters: you got to mount `root` first,
  then boot cause you're mounting inside `root`.

Result: `/mnt` now is a filesystem that will represent the same as your system
once installed - `/mnt` = `/` of the new system. All copied or installed in
`/mnt` from here, keeps over reboot; all out of the `/mnt` dir, will be lost
to reboot.

## nixos-generate-config

You now need to create a file `/mnt/etc/nixos/configuration.nix` that specifies
the intended configuration of the system. This is because NixOS has a
declarative configuration model: you create or edit a description of the
desired configuration of your system, and then NixOS takes care of making it
happen.

This command accepts an optional --flake option, to also generate a flake.nix file, if you want to set up a flake-based configuration.

The command nixos-generate-config can generate an initial configuration file for you:

```bash
nixos-generate-config --root /mnt
```

You should then edit /mnt/etc/nixos/configuration.nix to suit your needs:

```bash
nano /mnt/etc/nixos/configuration.nix
```

Another critical option is fileSystems, specifying the file systems that need
to be mounted by NixOS. However, you typically don’t need to set it yourself,
because nixos-generate-config sets it automatically in
`/mnt/etc/nixos/hardware-configuration.nix` from your currently mounted file
systems. (The configuration file `hardware-configuration.nix` is included from
`configuration.nix` and will be overwritten by future invocations of
`nixos-generate-config`; thus, you generally should not modify it.)
Additionally, you may want to look at Hardware configuration for known-hardware
at this point or after installation.

## nix-config install

Do the installation

```bash
nixos-install
```

or better, use a flake

```bash
nixos-install --flake <path/to/the/flake.nix#nixos>
```

From here, we have our system in `/mnt` or if reboot and restart the system as
it should be, on `/`, so, we need to install the configuration of the nixos system.
In this way, we first need to reboot and assuming that we're still in root, so
we'll install git for a minute with nix in a self contained shell.

```bash
nix-shell -p git
```

In this way we can use git for a minute in a temporary shell, so we add our
configuration repo and install the host that we require, in this repo, we
have just `rpi-server` and `ruhtra` as our hosts (`ruhtra` not implemented yet),
and we then use

```bash
git clone --depth 1 https://github.com/alexmatiasas/nix-config.git /tmp \
cp /etc/nixos/hardware-configuration.nix /tmp/nix-config/hosts/rpi-server/ \
rm /etc/nixos/configuration.nix
nixos-rebuild switch --flake /tmp/nix-config#rpi-server
```

or change rpi-server for the host necessary. The `etc/nixos/configuration.nix`
is removed as this is the default value for installation and as we will use
`nix-config/` as our flake configuration, then we don't need it, another way to
change this, is creating a soft link for `configuration.nix` to the repo.

---

```sh
infocmp -x xterm-ghostty | ssh alexmatias@192.168.64.11 'tic -x -'
```

---
