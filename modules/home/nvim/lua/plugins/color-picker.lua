return {
  "uga-rosa/ccc.nvim",
  cmd = { "CccPick", "CccConvert", "CccHighlighterEnable" },
  keys = {
    -- Presiona <leader>cp (normalmente Espacio + c + p) para abrir el selector sobre un color
    { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color Picker (Selector)" },
    { "<leader>co", "<cmd>CccConvert<cr>", desc = "Convertir formato de color" },
  },
  opts = {
    highlighter = {
      auto_enable = false, -- Lo dejamos en false porque ya usamos nvim-colorizer para esto
    },
  },
}
