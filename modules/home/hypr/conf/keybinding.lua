-- Direct require (NOT load_variant): DMS's keybind cheatsheet parser only
-- follows literal require() calls, so the load_variant() indirection made
-- conf/keybindings/*.lua invisible to `dms ipc call keybinds toggle`.
-- Tradeoff: switching keybinding variants from a settings app no longer
-- works — edit the require below instead.
require("conf.keybindings.default")