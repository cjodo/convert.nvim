local convert = require('convert.converters')
local utils = require("convert.utils")

local M = {}


---@param from string
---@param to string
---@param val number
---@return string
M.convert = function(from, to, val)
	if from == to then
		if from == 'hex' then
			return '#' .. val
		end

		if (from == 'rgb') then
			return tostring(val)
		end

		return val .. from
	end

	local round = 0

	if (to ~= 'px') then
		round = 2
	end

	local result = convert(from, to, val)

	if to == 'rgb' or to == 'hsl' then
		return result
	end

	if to == 'hex' then
		return "#" .. result
	end

	return tostring(utils.round(result, round)) .. to
end

return M
