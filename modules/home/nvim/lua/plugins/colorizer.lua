return {
  "NvChad/nvim-colorizer.lua",
  event = "LazyFile", -- Lo carga eficientemente al abrir cualquier archivo
  opts = {
    user_default_options = {
      AARRGGBB = true,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      mode = "background", -- Colorea el fondo del texto
    },
  },
}
