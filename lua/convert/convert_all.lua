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

		local all_units = utils.find_all_units_in_line(line, row)
		if all_units ~= nil and #all_units > 0 and all_units[1].unit == from then
			for i = #all_units, 1, -1 do
				local found = all_units[i]
				local converted = calculator.convert(from, to, found.val)

				vim.api.nvim_buf_set_text(
					bufnr,
					found.pos.row - 1,
					found.pos.start_col - 1,
					found.pos.row - 1,
					found.pos.end_col,
					{ converted }
				)
			end
		end
	end
end

return convert_all
