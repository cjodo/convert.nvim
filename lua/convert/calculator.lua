local converters = require('convert.converters')

local M = {}

M.convert = function (from, to, val)

	print(converters[from][to](val))
end

return M
