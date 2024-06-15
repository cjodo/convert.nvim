local converters = require('convert.converters')
local utils = require("convert.utils")

local M = {}

---@param from string
---@param to string
---@param val number
---@param base_font string
M.convert = function (from, to, val)
	if from == to then
		return val
	end
	local round = 0

	if(to ~= 'px') then
		round = 2
	end

	local res = converters[from][to](val)

	return utils.round(res, round)
end

return M
