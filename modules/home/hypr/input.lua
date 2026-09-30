-- -----------------------------------------------------
-- Input
-- -----------------------------------------------------
-- ref: https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
	input = {
		accel_profile = "adaptive", -- "adaptive", "flat", "custom"
		kb_layout = "latam, us, jp, de",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:alt_shift_toggle",
		kb_rules = "",

		follow_mouse = 1,
		natural_scroll = true, -- This is for mouse

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
		},
	},
})
