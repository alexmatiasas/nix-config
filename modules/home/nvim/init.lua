-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.g.root_spec = { "cwd" }

-- Force native transparency in LazyVim
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })

-- keymaps respecting logical lines
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

pcall(function()
  require("tokyonight").setup({
    transparent = true, -- Enable theme transparency
    styles = {
      sidebars = "transparent", -- Panels like Neo-tree transparent
      floats = "transparent", -- Floating Windows transparent
    },
  })
  -- Reload the theme to apply changesRecargar el tema para aplicar los cambios
  vim.cmd([[colorscheme tokyonight]])
end)

vim.api.nvim_create_autocmd("DirChanged", {
  callback = function(ev)
    vim.notify("cwd cambió a: " .. ev.file .. "\nscope: " .. vim.v.event.scope, vim.log.levels.WARN)
  end,
})
