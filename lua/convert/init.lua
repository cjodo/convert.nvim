local utils = require("convert.utils")
local units = require("convert.patterns")

local M = {}

M.find_next = function ()
	local cursor_pos =	utils.get_cursor_pos()
	local buf = vim.api.nvim_get_current_buf()
	local current_win = vim.api.nvim_get_current_win()
	local lines = vim.api.nvim_buf_get_lines(buf, cursor_pos.row - 1, -1, true)

	local found_unit = nil

	for row = 1, #lines, 1 do
		local line = lines[row]
		local unit = utils.match_unit(line, units) -- Returns the found unit and start column of found unit

		if unit ~= nil then
			-- based on current pos.. row 1 would indicate current row
			found_unit = unit
		end

	end

	if found_unit ~= nil then
		vim.api.nvim_win_set_cursor(current_win, {#lines - cursor_pos.row - 1, found_unit.pos.s - 1})
		utils.get_base_font_size()
	end
end

return M
