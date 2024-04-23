local utils = require("convert.utils")

local base_font_size = utils.get_base_font_size() or 16

---@return integer
local converters = { -- pattern is like this: converters[from][to](value_from) 
	px = {
		---@param val integer
		rem = function (val)
			return val / base_font_size
		end,
		em = function (val)
			return val / base_font_size -- TODO: Not quite how this works but close enough for now
		end,
		cm = function (val)
			return val * 0.0264583333
		end,
		inch = function (val)
			return val * 0.010417
		end,
		pt = function (val)
			return val * 0.74999943307122
		end
	},
	pt = {
		rem = function (val)
			local px = val * (4/3)
			return px / base_font_size
		end,
		em = function (val)
			local px = val * (4/3)
			return px / base_font_size
		end,
		cm = function (val)
			return val * 0.0352778
		end,
		inch = function (val)
			return val * 0.0138889
		end,
		px = function (val)
			return val * (4/3)
		end
	},
	-- rem = {
	--
	-- },
	-- em = {
	--
	-- },
	-- mm = {
	--
	-- },
	-- cm = {
	-- },
}

return converters
