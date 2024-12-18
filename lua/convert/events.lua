local parser = require("convert.parsers.base_font")
local utils = require("convert.utils")
local state = require("convert.state")
local config = require("convert.config")

local M = {}

local events = {
	"BufWritePost",
	"BufEnter",
	"BufNew"
}

M.setup = function()
	vim.api.nvim_create_autocmd(events, {
		pattern = config.patterns,
		callback = function(e)
			vim.inspect(e)
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
