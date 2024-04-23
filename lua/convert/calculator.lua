local converters = require('convert.converters')

local M = {}

M.convert = function (from, to, val)
	--convert px to rem
	converters[from][to](val)
end

return M
