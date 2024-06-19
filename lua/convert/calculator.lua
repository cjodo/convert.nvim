local converters = require('convert.converters')
local utils = require("convert.utils")

local M = {}

---@param from string
---@param to string
---@param val number
M.convert = function(from, to, val)
	print(from, to, val)
	if from == to then
		if from == 'hex' then
			return '#' .. val
		end

		if (from == 'rgb') then
			return val
		end

		return val .. from
	end

	local round = 0

	if (to ~= 'px') then
		round = 2
	end

	local res = converters(from, to, val)

	if to == 'rgb' or to == 'hsl' then
		return res
	end

	if to == 'hex' then
		return "#" .. res
	end

	return tostring(utils.round(res, round)) .. to
end

return M
