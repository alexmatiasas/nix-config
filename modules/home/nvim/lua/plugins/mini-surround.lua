return {
  "nvim-mini/mini.surround",
  opts = {
    custom_surroundings = {
      -- 1. Negritas ('b') - Totalmente inmune al auto-guardado
      b = {
        input = { "%*%*().-(%*%*)" },
        output = { left = "**", right = "**" },
      },
      -- 2. Enlaces de Markdown ('l') - Apaga el auto-guardado usando comandos nativos seguros
      l = {
        input = { "%[().-(%)%.%*)" },
        output = function()
          -- Desactivamos temporalmente el auto-guardado usando el comando del plugin
          vim.cmd("ASToggle")

          -- Reactivamos el auto-guardado en el siguiente ciclo inmediato de Neovim
          vim.schedule(function()
            vim.cmd("ASToggle")
          end)

          return { left = "[", right = "]()" }
        end,
      },
      -- 3. Código Inline ('c')
      c = {
        input = { "`().-(`)" },
        output = { left = "`", right = "`" },
      },
    },
  },
}
