-- Configuration
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Applications (adapted: ML4W settings-app scripts don't exist here,
-- binaries come from Nix systemPackages — see nix-config)
-- === Application Launchers ===
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"), { description = "Open the terminal" })

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("flatpak run org.mozilla.firefox"), { description = "Open the filemanager" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"), { description = "Open the filemanager" })
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("dms ipc call spotlight toggle"), { description = "Toggle spotlight" })
hl.bind("ALT + space", hl.dsp.exec_cmd("dms ipc call spotlight-bar toggle"), { description = "Toggle spotlight bar" })
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("dms ipc call clipboard toggle"), { description = "Toggle clipboard history" })
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("dms ipc call processlist focusOrToggle"), { description = "Focus or toggle process list" })
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd("dms ipc call settings focusOrToggle"), { description = "Focus or toggle settings" })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("dms ipc call notifications toggle"), { description = "Toggle notifications" })
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("dms ipc call notepad toggle"), { description = "Toggle notepad" })
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("dms ipc call dash toggle wallpaper"), { description = "Toggle wallpaper" })
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"), { description = "Toggle overview" })
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"), { description = "Toggle overview" })
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("dms ipc call powermenu toggle"), { description = "Toggle power menu" })
-- hl.bind(mainMod .. " + CTRL + E", hl.dsp.exec_cmd("rofimoji"), { description = "Open the emoji picker" }) -- needs rofimoji installed
-- hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("gnome-calculator"), { description = "Open the calculator" }) -- needs a calculator

-- === Cheat sheet ===
hl.bind(mainMod .. " + SHIFT + Slash", hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"), { description = "Toggle keybindings cheat sheet" })
-- hl.bind(
--     mainMod .. " + CTRL + K",
--     hl.dsp.exec_cmd("~/.config/hypr/scripts/keybindings.sh"),
--     { description = "Show keybindings" }
-- )

-- === Security ===
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit(), { description = "Exit Hyprland" })
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"), { description = "Lock the screen" })
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("dms ipc call processlist focusOrToggle"), { description = "Open process list" })
-- -- Power/lock via DMS control center (no ML4W scripts here)
-- hl.bind(
--     mainMod .. " + SHIFT + R",
--     hl.dsp.exec_cmd("~/.config/hypr/scripts/loadconfig.sh"),
--     { description = "Reload hyprland config" }
-- )

-- === Audio Controls ===
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 3"), { locked = true, repeating = true, description = "Raise volume" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 3"), { locked = true, repeating = true, description = "Lower volume" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { locked = true, description = "Mute audio" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call audio micmute"), { locked = true, description = "Mute microphone" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true, description = "Pause audio" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true, description = "Play audio" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"), { locked = true, description = "Previous track" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"), { locked = true, description = "Next track" })
hl.bind("CTRL + XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call mpris increment 3"), { locked = true, repeating = true, description = "Raise volume" })
hl.bind("CTRL + XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call mpris decrement 3"), { locked = true, repeating = true, description = "Lower volume" })
-- ----------------------------------------------------------------------------
-- hl.bind(
--     "XF86AudioRaiseVolume",
--     hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
--     { locked = true, repeating = true, description = "Raise volume" }
-- )
-- hl.bind(
--     "XF86AudioLowerVolume",
--     hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
--     { locked = true, repeating = true, description = "Lower volume" }
-- )
-- hl.bind(
--     "XF86AudioMute",
--     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
--     { locked = true, repeating = true, description = "Mute audio" }
-- )
-- hl.bind(
--     "XF86AudioMicMute",
--     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
--     { locked = true, repeating = true, description = "Mute microphone" }
-- )
-- -- Requires playerctl (in systemPackages)
-- hl.bind(
--     "XF86AudioNext",
--     hl.dsp.exec_cmd("playerctl next"),
--     { locked = true, description = "Next track" }
-- )
-- hl.bind(
--     "XF86AudioPause",
--     hl.dsp.exec_cmd("playerctl play-pause"),
--     { locked = true, description = "Pause audio" }
-- )
-- hl.bind(
--     "XF86AudioPlay",
--     hl.dsp.exec_cmd("playerctl play-pause"),
--     { locked = true, description = "Play audio" }
-- )
-- hl.bind(
--     "XF86AudioPrev",
--     hl.dsp.exec_cmd("playerctl previous"),
--     { locked = true, description = "Previous track" }
-- )
-- ----------------------------------------------------------------------------

-- === Brightness Controls ===
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd([[dms ipc call brightness increment 5 ""]]), { locked = true, repeating = true, description = "Increase brightness" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[dms ipc call brightness decrement 5 ""]]), { locked = true, repeating = true, description = "Decrease brightness" })
-- ----------------------------------------------------------------------------
-- -- Laptop multimedia keys for volume and LCD brightness
-- hl.bind(
--     "XF86MonBrightnessUp",
--     hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
--     { locked = true, repeating = true, description = "Increase brightness" }
-- )
-- hl.bind(
--     "XF86MonBrightnessDown",
--     hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
--     { locked = true, repeating = true, description = "Decrease brightness" }
-- )
-- ----------------------------------------------------------------------------

-- === Windows Management ===
-- --- Special Config for French and Belgian languages ---
-- AZERTY keyboard layout setup
-- On AZERTY the number row needs Shift, so Hyprland sees the unshifted
-- keysyms instead of the digits. Map workspace 1-10 to those keysyms.
local azerty_keys = {
    fr = {
        "ampersand",
        "eacute",
        "quotedbl",
        "apostrophe",
        "parenleft",
        "minus",
        "egrave",
        "underscore",
        "ccedilla",
        "agrave",
    },
    be = {
        "ampersand",
        "eacute",
        "quotedbl",
        "apostrophe",
        "parenleft",
        "section",
        "egrave",
        "exclam",
        "ccedilla",
        "agrave",
    },
}

-- Variants of the layouts above that are not AZERTY
local non_azerty_variants = {
    fr = { us = true, bepo = true, bepo_afnor = true, dvorak = true },
    be = { wang = true },
}

local function detect_azerty()
    local f = io.open(os.getenv("HOME") .. "/.config/hypr/input.lua", "r")
    if not f then
        return nil
    end
    local content = f:read("*all")
    f:close()

    -- kb_layout may be a list ("be,us"); the first entry is the primary one
    local layout = content:match('kb_layout%s*=%s*"([^",]*)')
    local variant = content:match('kb_variant%s*=%s*"([^",]*)') or ""
    if not layout then
        return nil
    end
    layout = layout:lower():gsub("%s", "")
    variant = variant:lower():gsub("%s", "")

    local excluded = non_azerty_variants[layout]
    if excluded and excluded[variant] then
        return nil
    end
    return azerty_keys[layout]
end

local ws_keys = detect_azerty()

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = ws_keys and ws_keys[i] or (i % 10) -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Focus workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
end
-- --- HERE ENDS THE SPECIAL CONFIG FOR French, Belgian ---

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("~/.config/hypr/scripts/killactive.sh"), { description = "Kill active window" })
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"), { description = "Quit active window and all open instances" })
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Toggle Fullscreen" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }), { description = "Toggle Maximize Window" })
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle Floating" })
hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("dms ipc call window-rules toggle"), { description = "Toggle window rules for active window" })
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggleallfloat.sh"), { description = "Toggle floating for all windows of workspace" })
hl.bind(mainMod .. " + ALT + T", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.pin())
end, { description = "Toggle floating + pinned" })
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle split" })

-- === Focus Navigation ===
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }), { description = "Move focus left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }), { description = "Move focus up" })
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }), { description = "Move focus down" })
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }), { description = "Move focus left" })
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }), { description = "Move focus down" })
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }), { description = "Move focus up" })
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })

-- === Window drag and resize ===
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with the mouse" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with the mouse" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true }, { description = "Increase window width with keyboard" })
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true }, { description = "Reduce window width with keyboard" })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true }, { description = "Increase window height with keyboard" })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true }, { description = "Reduce window height with keyboard" })
-- hl.bind(mainMod .. " + SHIFT + G", hl.dsp.group.active("f"), { description = "Switch to next group window" })

-- === Windows Split and swaping ===
hl.bind(mainMod .. " + K", hl.dsp.layout("swapsplit"), { description = "Swapsplit" })
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "l" }), { description = "Swap tiled window left" })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }), { description = "Swap tiled window right" })
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "u" }), { description = "Swap tiled window up" })
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "d" }), { description = "Swap tiled window down" })

-- === Window Movement ===
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }), { description = "Move window left" })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }), { description = "Move window down" })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }), { description = "Move window up" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }), { description = "Move window right" })
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }), { description = "Move window left" })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }), { description = "Move window down" })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }), { description = "Move window up" })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }), { description = "Move window right" })

-- === Column Navigation ===
hl.bind(mainMod .. " + Home", hl.dsp.focus({ window = "first" }), { description = "Focus first window in workspace" })
hl.bind(mainMod .. " + End", hl.dsp.focus({ window = "last" }), { description = "Focus last window in workspace" })

-- === Monitor Navigation ===
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ monitor = "l" }), { description = "Focus monitor left" })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ monitor = "r" }), { description = "Focus monitor right" })
hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ monitor = "l" }), { description = "Focus monitor left" })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.focus({ monitor = "d" }), { description = "Focus monitor down" })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.focus({ monitor = "u" }), { description = "Focus monitor up" })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ monitor = "r" }), { description = "Focus monitor right" })

-- === Move to Monitor ===
hl.bind(mainMod .. " + SHIFT + CTRL + left", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + CTRL + down", hl.dsp.window.move({ monitor = "d" }))
hl.bind(mainMod .. " + SHIFT + CTRL + up", hl.dsp.window.move({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + CTRL + right", hl.dsp.window.move({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }), { description = "Move window to monitor left" })
hl.bind(mainMod .. " + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "d" }), { description = "Move window to monitor down" })
hl.bind(mainMod .. " + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "u" }), { description = "Move window to monitor up" })
hl.bind(mainMod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }), { description = "Move window to monitor right" })

-- === Workspace Navigation ===
hl.bind(mainMod .. " + Page_Down", hl.dsp.focus({ workspace = "e+1" }), { description = "Focus next workspace" })
hl.bind(mainMod .. " + Page_Up", hl.dsp.focus({ workspace = "e-1" }), { description = "Focus previous workspace" })
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "e+1" }), { description = "Focus next workspace" })
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "e-1" }), { description = "Focus previous workspace" })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ workspace = "e+1" }), { description = "Move window to next workspace" })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ workspace = "e-1" }), { description = "Move window to previous workspace" })
hl.bind(mainMod .. " + CTRL + U", hl.dsp.window.move({ workspace = "e+1" }), { description = "Move window to next workspace" })
hl.bind(mainMod .. " + CTRL + I", hl.dsp.window.move({ workspace = "e-1" }), { description = "Move window to previous workspace" })

-- === Workspace Management ===
hl.bind("CTRL + SHIFT + R", hl.dsp.exec_cmd("dms ipc call workspace-rename open"), { description = "Rename current workspace" })

-- === Scratchpad ===
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad"), { description = "Toggle special workspace scratchpad" })
hl.bind(mainMod .. " + SHIFT + S", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.move({ workspace = "special:scratchpad" }))
end, { description = "Move window to special workspace scratchpad" })

-- hl.bind(
--     mainMod .. " + SHIFT + S",
--     hl.dsp.window.move({ workspace = "special", follow = false })
-- )

hl.bind(mainMod .. " + CTRL + S", hl.dsp.window.move({ workspace = "+0" }), { description = "Move window to current workspace" })

-- === Move Workspaces ===
hl.bind(mainMod .. " + SHIFT + Page_Down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + Page_Up", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.move({ workspace = "e+1" }), { description = "Move window to next workspace" })
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.window.move({ workspace = "e-1" }), { description = "Move window to previous workspace" })

-- === Mouse Wheel Navigation ===
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Switch to next workspace" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Switch to previous workspace" })
hl.bind(mainMod .. " + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }), { description = "Move window to next workspace" })
hl.bind(mainMod .. " + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }), { description = "Move window to previous workspace" })

-- === Numbered Workspaces ===
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = "1" }), { description = "Focus workspace 1" })
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = "2" }), { description = "Focus workspace 2" })
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = "3" }), { description = "Focus workspace 3" })
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = "4" }), { description = "Focus workspace 4" })
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = "5" }), { description = "Focus workspace 5" })
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = "6" }), { description = "Focus workspace 6" })
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = "7" }), { description = "Focus workspace 7" })
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = "8" }), { description = "Focus workspace 8" })
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = "9" }), { description = "Focus workspace 9" })

-- === Move to Numbered Workspaces ===
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }), { description = "Move window to workspace 1" })
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }), { description = "Move window to workspace 2" })
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }), { description = "Move window to workspace 3" })
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }), { description = "Move window to workspace 4" })
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }), { description = "Move window to workspace 5" })
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }), { description = "Move window to workspace 6" })
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }), { description = "Move window to workspace 7" })
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }), { description = "Move window to workspace 8" })
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }), { description = "Move window to workspace 9" })

-- === Column Management ===
hl.bind(mainMod .. " + bracketleft", hl.dsp.layout("preselect l"), { description = "Preselect left split" })
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("preselect r"), { description = "Preselect right split" })

-- === Sizing & Layout ===
hl.bind(mainMod .. " + R", hl.dsp.layout("togglesplit"), { description = "Toggle split layout" })
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "set" }), { description = "Set window to maximized" })

-- === Move/resize windows with mainMod + LMB/RMB and dragging ===
-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with the mouse" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with the mouse" })
hl.bind(mainMod .. " + code:20", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { description = "Expand window left" })
hl.bind(mainMod .. " + code:21", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { description = "Shrink window left" })

-- === Manual Sizing ===
hl.bind(mainMod .. " + minus", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true, description = "Shrink window width" })
hl.bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true, description = "Expand window width" })
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true, description = "Shrink window height" })
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true, description = "Expand window height" })

-- === Actions ===
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reload Hyprland configuration" })
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-animations.sh"), { description = "Toggle animations" })

-- === Screenshots ===
hl.bind("Print", hl.dsp.exec_cmd("dms screenshot"), { description = "Take a screenshot" })
-- hl.bind(
--     mainMod .. " + PRINT",
--     hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"),
--     { description = "Take a screenshot" }
-- )
hl.bind("CTRL + Print", hl.dsp.exec_cmd("dms screenshot full"), { description = "Take a full-screen screenshot" })
-- hl.bind(
--     mainMod .. " + ALT + F",
--     hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --instant"),
--     { description = "Take an instant full-screen screenshot" }
-- )
hl.bind("ALT + Print", hl.dsp.exec_cmd("dms screenshot window"), { description = "Take a window screenshot" })
-- hl.bind(
--     mainMod .. " + ALT + S",
--     hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh --instant-area"),
--     { description = "Take an instant area screenshot" }
-- )

hl.bind(mainMod .. " + ALT + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/text-extractor.sh"), { description = "Extract text from an area" })
-- Clipboard via DMS widget (cliphist daemon runs at autostart)
hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd("~/.config/hypr/scripts/gamemode.sh"), { description = "Toggle game mode" })

--------------------------------------------------------

-- === Display Profiles ===
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("dms ipc outputs cycleProfile"))

-- === System Controls ===
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.dpms({ action = "toggle" }))
