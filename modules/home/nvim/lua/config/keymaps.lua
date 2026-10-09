-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-7>", function()
  Snacks.terminal.toggle()
end, { desc = "Open Terminal" })

vim.keymap.set("t", "<C-7>", "<cmd>close<cr>", { desc = "Close Terminal" })
