local utils = require("convert.utils")

local M = {}

---@class matched
---@field unit string
---@field val number
---@field pos matched_pos

---@class matched_entry : matched
---@field bufnr integer
---@field line string

M.collect_buffer_matches = function ()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local results = {}

  for row, line in ipairs(lines) do
    local matches = utils.find_all_units_in_line(line, row)
    if matches then
      for _, m in ipairs(matches) do
        -- enrich here
        m.bufnr = bufnr
        m.line = line

        table.insert(results, m)
      end
    end
  end

  return results
end

return M
