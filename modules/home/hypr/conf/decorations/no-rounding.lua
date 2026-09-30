-- -----------------------------------------------------
-- General window decoration
-- name: "No Rounding"
-- -----------------------------------------------------
-- ref: https://wiki.hypr.land/configuring/core/config-options/#decoration

hl.config({
    decoration = {
        rounding = 0,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1.0,
        rounding_power = 2,

        shadow = {
            enabled = true,
            range = 32,
            render_power = 2,
            color = "rgba(00000050)",
        },

        blur = {
            enabled = true,
            size = 4,
            passes = 4,
            -- new_optimizations = true, -- true by default
            -- ignore_opacity = true, -- true by default
            xray = true,
            vibrancy = 0.1696,
        },
    },
})
