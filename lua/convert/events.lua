local parser = require("convert.parsers.base_font")
local utils = require("convert.utils")
local state = require("convert.state")

local M = {}

M.setup = function()
	vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "BufNew" }, {
		pattern = { "*.css", "*.scss", "*.tsx", "*.ts", "*.js", "*.jsx" },
		callback = function()
			local file_path = vim.fn.expand('%')
			local cursor = utils.get_cursor_pos()
			local base_font = parser.base_font(file_path, cursor.row)

			if base_font == nil then
				state.set_base_font(16, 'px')
				return
			end
			state.set_base_font(base_font.size, base_font.unit)
		end
	})
end

return M
