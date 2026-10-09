return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tinymist = {
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("main.typ", "typst.toml", ".git")(fname)
        end,
        settings = {
          exportPdf = "onSave",
          formatterMode = "typstyle",
        },
      },
      ltex = {
        settings = {
          ltex = {
            language = "es-MX",
          },
        },
      },
      nil_ls = false,
      nixd = {},
    },
  },
}
