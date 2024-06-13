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
	rem = {
		px = function (val)
			return val * base_font_size
		end,
		em = function (val)
			return val -- Assuming 1rem = 1em for simplicity
		end,
		cm = function (val)
			local px = val * base_font_size
			return px * 0.0264583333
		end,
		inch = function (val)
			local px = val * base_font_size
			return px * 0.010417
		end,
		pt = function (val)
			local px = val * base_font_size
			return px * 0.74999943307122
		end
	},
 em = {
        px = function (val)
            return val * base_font_size -- Assuming 1em = base_font_size in pixels
        end,
        rem = function (val)
            return val -- Assuming 1em = 1rem for simplicity
        end,
        cm = function (val)
            local px = val * base_font_size
            return px * 0.0264583333
        end,
        inch = function (val)
            local px = val * base_font_size
            return px * 0.010417
        end,
        pt = function (val)
            local px = val * base_font_size
            return px * 0.74999943307122
        end
    },
    mm = {
        px = function (val)
            return val * 3.7795275591
        end,
        rem = function (val)
            local px = val * 3.7795275591
            return px / base_font_size
        end,
        em = function (val)
            local px = val * 3.7795275591
            return px / base_font_size
        end,
        cm = function (val)
            return val * 0.1
        end,
        inch = function (val)
            return val * 0.0393701
        end,
        pt = function (val)
            return val * 2.8346456693
        end
    },
    cm = {
        px = function (val)
            return val * 37.795275591
        end,
        rem = function (val)
            local px = val * 37.795275591
            return px / base_font_size
        end,
        em = function (val)
            local px = val * 37.795275591
            return px / base_font_size
        end,
        mm = function (val)
            return val * 10
        end,
        inch = function (val)
            return val * 0.393701
        end,
        pt = function (val)
            return val * 28.346456693
        end
    },
}

return converters
