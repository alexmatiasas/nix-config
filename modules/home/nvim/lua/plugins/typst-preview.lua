return {
  "chomosuke/typst-preview.nvim",
  cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" },
  keys = {
    { "<leader>cp", ft = "typst", "<cmd>TypstPreviewToggle<cr>", desc = "Toggle Typst Preview" },
  },
  opts = {
    dependencies_bin = { tinymist = "tinymist" },
    get_main_file = function(path_of_buffer)
      local dir = vim.fn.fnamemodify(path_of_buffer, ":p:h")
      while dir ~= "/" do
        local toml = dir .. "/typst.toml"
        if vim.fn.filereadable(toml) == 1 then
          local content = table.concat(vim.fn.readfile(toml), "\n")
          local entry = content:match('entry%s*=%s*"([^"]+)"')
          if entry then
            return dir .. "/" .. entry
          end
        end
        if vim.fn.filereadable(dir .. "/main.typ") == 1 then
          return dir .. "/main.typ"
        end
        dir = vim.fn.fnamemodify(dir, ":h")
      end
      return path_of_buffer
    end,
  },
  config = function(_, opts)
    require("typst-preview").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "typst",
      callback = function(args)
        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            vim.cmd("TypstPreview")
          end
        end, 500)
      end,
    })
  end,
}
