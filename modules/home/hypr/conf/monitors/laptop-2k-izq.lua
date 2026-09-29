-------------------------------------------------------
-- Monitor Setup
-- name: "laptop-2k-izq"
-- Use: 2k external monitor on the LEFT (0x0), laptop on the right (2560x0).
-- Active only when you connect the 2K. See conf/monitor.lua to activate.
-- Change "desc:TU-MODELO-2K" to your actual desc (`hyprctl monitors all`).
-------------------------------------------------------

hl.monitor({
    output = "desc:TU-MODELO-2K", -- hyprctl monitors all
    mode = "preferred",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "2560x0",
    scale = 1,
})
