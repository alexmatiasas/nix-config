-- ref: https://wiki.hypr.land/configuring/core/autostart/

hl.on("hyprland.start", function()
    -- Export variables to systemd so portal backends catch the environment
    -- (uwsm does this too; harmless duplicate, required without it).
    hl.exec_cmd(
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    )

    -- Restart portals so they catch the environment
    hl.exec_cmd(
        "systemctl --user stop xdg-desktop-portal xdg-desktop-portal-hyprland"
    )
    hl.exec_cmd(
        "systemctl --user start xdg-desktop-portal-hyprland xdg-desktop-portal"
    )

    -- Cursor (capitaine-cursors ships with the system; verify with
    -- `ls /run/current-system/sw/share/icons | grep -i capitaine`)
    hl.exec_cmd("hyprctl setcursor capitaine-cursors 24")

    -- DMS shell: bar, dock, launcher, notifications, wallpaper, idle/lock.
    -- Single autostart mechanism (systemd service stays OFF in dms.nix).
    hl.exec_cmd("dms run --session")

    -- Polkit agent (hyprpolkitagent in systemPackages)
    hl.exec_cmd("hyprpolkitagent")

    -- Clipboard history daemon (cliphist + wl-clipboard in systemPackages)
    hl.exec_cmd("wl-paste --watch cliphist store")

    -- Local helper scripts
    hl.exec_cmd("~/.config/hypr/scripts/cleanup.sh")
end)
