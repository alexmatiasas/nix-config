return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        win = {
          input = {
            keys = {
              -- 3. Le asignamos a Ctrl+i la función de alternar ignorados
              ["<C-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            },
          },
        },
      },
    },
  },
}
