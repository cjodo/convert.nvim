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
	mm = 4.3,
	['in'] = 0.17,
	cm = 0.42,
	pc = 1,
	pt = 12
}

describe("Unit Conversions", function()
	for unit, value in pairs(size_values) do
		for i = 1, #units, 1 do
			local round = 2

			if to == 'px' then
				round = 0
			end

			local from = unit
			local to = units[i]
			if from == to then
				goto continue
			end

			it(string.format("Should convert %s, to %s", from, to), function()
				local converted = utils.round(converters(from, to, value), round)
				assert.are.equal(converted, size_values[to])
			end)
		end
		::continue::
	end
end)
