local utils = require("convert.utils")
local calculator = require("convert.calculator")

local convert_all = function(bufnr, from, to)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	for row = 1, #lines, 1 do
		local line = lines[row]

		local found_unit = utils.find_unit_in_line(line, row)

		if found_unit ~= nil and found_unit.unit == from then
			local converted = calculator.convert(from, to, found_unit.val)

			vim.api.nvim_buf_set_text(bufnr, found_unit.row - 1, found_unit.start_col - 1, found_unit.row - 1,
				found_unit.end_col,
				{ converted })
		end
	end
end

return convert_all
