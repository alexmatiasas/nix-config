-- lua/plugins/nix.lua
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
      servers = {
        nil_ls = false,
      },
    },
  },
}
