local converters = require("lua/convert.converters")
local utils = require("lua/convert.utils")

local units = {
	'px',
	'rem',
	-- 'mm',
	'in',
	'cm',
	'pc',
	'pt'
}

local size_values = {
	px = 16,
	rem = 1.0,
	-- mm = 4.23,
	['in'] = 0.17,
	cm = 0.42,
	pc = 1,
	pt = 12
}

local number_val = {
	bin = "0b0101",
	hex = "0x155",
	octal = "0o525",
	decimal = "341"
}

describe("Unit Conversions", function()
	for unit, value in pairs(size_values) do
		for i = 1, #units, 1 do
			local round = 2

			local to_unit = units[i]
			local from_unit = unit

			if from_unit == to_unit then
				goto continue
			end

			if to_unit == 'px' or to_unit == 'rem' then
				round = 0
			end

			it(string.format("Should convert %s, to %s", from_unit, to_unit), function()
				local converted = utils.round(converters(from_unit, to_unit, value), round)
				assert.are.equal(size_values[to_unit], converted)
			end)
		end
		::continue::
	end
end)

describe("Number Conversions", function()
	for unit, value in pairs(number_val) do
		for i = 1, #units, 1 do

			local to_unit = units[i]
			local from_unit = unit

			if from_unit == to_unit then
				goto continue
			end


			it(string.format("Should convert %s, to %s", from_unit, to_unit), function()
				local converted = utils.round(converters(from_unit, to_unit, value), 0)
				assert.are.equal(size_values[to_unit], converted)
			end)
		end
		::continue::
	end
end)
