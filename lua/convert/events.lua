local parser = require("convert.parsers.base_font")
local utils = require("convert.utils")
local state = require("convert.state")

local M = {}

local events = {
	"BufWritePost",
	"BufEnter",
	"BufNew"
}

M.setup = function()
	vim.api.nvim_create_autocmd(events, {
		pattern = { "*.css", "*.scss", "*.tsx", "*.ts", "*.js", "*.jsx" },
		callback = function(e)
			vim.inspect(e)
			local file_path = vim.fn.expand('%')
			local cursor = utils.get_cursor_pos()
			local base_font = parser.base_font(file_path, cursor.row)

			if base_font == nil or base_font.size == nil then
				state.set_base_font(16, 'px')
				return
			end
			print("Setting base font", base_font.size, base_font.unit)
			state.set_base_font(base_font.size, base_font.unit)
		end
	})
end

return M
