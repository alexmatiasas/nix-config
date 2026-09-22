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

512MB 100% — empieza justo donde terminó la ESP (megabyte 512) y usa todo el resto del disco (100%). Esta va a ser la partición número 2.

`512MB 100%` - starts just right where the ESP partition ends (megabyte 512),
and uses the rest of the disk (100%). This gonna be the number 2 partition.

### Format each partition

```bash
mkfs.fat -F32 -n boot /dev/vda1
mkfs.ext4 -L nixos /dev/vda2
```

mkfs.fat -F32 -n boot /dev/vda1 — formatea la partición 1 (la ESP) como FAT32 específicamente (-F32, existen FAT12/16/32, necesitas 32). -n boot le pone una etiqueta (LABEL=boot) — esto es lo que te va a permitir referenciar la partición por nombre en vez de por ruta cruda en el siguiente paso, y es lo que NixOS usa en el hardware-configuration.nix generado para que no importe si el disco cambia de /dev/vda a /dev/sda entre reinicios.

mkfs.ext4 -L nixos /dev/vda2 — formatea la partición 2 con el filesystem ext4 (el estándar de Linux, robusto y bien soportado — no necesitas nada más exótico para esto). -L nixos es la misma idea, etiqueta la partición como nixos.

### Mount the partitions

---

```sh
infocmp -x xterm-ghostty | ssh alexmatias@192.168.64.11 'tic -x -'
```

---
