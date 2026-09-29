-- This file is used to load the monitor configuration for Hyprland.
-- It is loaded by the main configuration file (default.lua) and can
-- be overridden by the user.
-- Just override `local name` with any of the other configurations in
-- conf/monitors/<config>.lua
-- Example: `local name = "laptop.lua"` to load the laptop configuration.
local name = "default.lua"
load_variant(name, "monitors")
