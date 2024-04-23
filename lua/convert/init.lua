local utils = require("convert.utils")
local units = require("convert.patterns")
local calculator = require('convert.calculator')

local M = {}

local current_line = nil

M.find_next = function ()
	local cursor_pos =	utils.get_cursor_pos()
	local buf = vim.api.nvim_get_current_buf()
	local current_win = vim.api.nvim_get_current_win()
	local lines = vim.api.nvim_buf_get_lines(buf,  0, -1, true)

	local found_unit = nil

	for row = cursor_pos.row, #lines, 1 do
		if current_line ~= nil then
			current_line = nil
			goto continue
		end
		local line = lines[row]
		local unit = utils.match_unit(line, units) -- Returns the found unit and start column of found unit

		if unit ~= nil then
			-- based on current pos.. row 1 would indicate current row
			found_unit = unit
			found_unit.row = row
			current_line = row
			break
		end
	    ::continue::
	end

	if found_unit ~= nil then
		print(found_unit.val)
		calculator.convert(found_unit.unit, 'rem', found_unit.val)
		vim.api.nvim_win_set_cursor(current_win, {found_unit.row, found_unit.pos.s - 1})
	end
end

return M
