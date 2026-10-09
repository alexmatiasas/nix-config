return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" },
      defer_save = { "InsertLeave", "TextChanged" },
      cancel_deferred_save = { "InsertEnter" },
    },
    debounce_delay = 1000, -- ms de espera tras dejar de escribir
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")

      -- no autoguardar buffers sin nombre, especiales, ni mensajes de commit
      if
        fn.getbufvar(buf, "&modifiable") == 1
        and utils.not_in(fn.getbufvar(buf, "&filetype"), { "gitcommit", "gitrebase" })
      then
        return true
      end
      return false
    end,
  },
}
