local converters = require("lua/convert.converters")
local utils = require("lua/convert.utils")

local units = {
	'px',
	'rem',
	'mm',
	'in',
	'cm',
	'pc',
	'pt'
}

local size_values = {
	px = 16,
	rem = 1,
	mm = 4.23,
	['in'] = 0.17,
	cm = 0.42,
	pc = 1,
	pt = 12
}

describe("Unit Conversions", function()
	for unit, value in pairs(size_values) do
		for i = 1, #units, 1 do
			local round = 2

			if to_unit == 'px' then
				round = 0
			end

			local from_unit = unit
			local to_unit = units[i]
			if from_unit == to_unit then
				goto continue
			end

			it(string.format("Should convert %s, to %s", from_unit, to_unit), function()
				local converted = utils.round(converters(from_unit, to_unit, value), round)
				print(from_unit, to_unit, converted)
				assert.are.equal(converted, utils.round(size_values[to_unit], round))
			end)
		end
		::continue::
	end
end)
