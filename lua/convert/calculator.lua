local converters = require('convert.converters')

local M = {}

---@param from string
---@param to string
---@param val number
M.convert = function (from, to, val)
	return converters[from][to](val)
end

return M
