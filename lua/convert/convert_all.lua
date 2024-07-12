local utils = require("convert.utils")
local calculator = require("convert.calculator")
local units = require("convert.units")

local convert_all = function(bufnr, from, to)
	local from_type = nil
	local to_type = nil
	if utils.contains(units.size_units, from) then
		from_type = 'color'
	else
		from_type = 'size'
	end

	if utils.contains(units.size_units, to) then
		to_type = 'color'
	else
		to_type = 'size'
	end
	if from_type ~= to_type then
		print(string.format("Can't convert %s to %s units", from_type, to_type))
		return
	end


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
