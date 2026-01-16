local previewers = require("telescope.previewers")

local M = {}

M.convert_previewer = previewers.new_buffer_previewer({
  title = "Convert Preview",

  define_preview = function(self, entry)
    local buf = self.state.bufnr

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
      entry.line,
    })

    vim.api.nvim_buf_set_option(buf, "filetype", vim.bo.filetype)

    -- Lua strings are 1-indexed; Neovim cols are 0-indexed
    vim.api.nvim_buf_add_highlight(
      buf,
      -1,
      "IncSearch",
      0,
      entry.pos.start_col - 1,
      entry.pos.end_col
    )
  end,
})

return M
