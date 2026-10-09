return {
  "stevearc/conform.nvim",
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 500,
      undojoin = true, -- fusiona el formateo con tu último cambio en el historial de undo
    },
  },
}
