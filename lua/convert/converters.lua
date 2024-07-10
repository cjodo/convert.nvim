local patterns = require("convert.patterns")
local state = require("convert.state")

local converters = {}

converters['px'] = {
	rem = function(val)
		return val / state.get_base_font().size
	end,
	cm = function(val)
		return val * 0.0264583333
	end,
	['in'] = function(val)
		return val * 0.010417
	end,
	pt = function(val)
		return val * 0.74999943307122
	end,
	mm = function(val)
		return val * 0.264583333
	end,
	pc = function(val)
		return val * 0.0625
	end
}

converters['pt'] = {
	rem = function(val)
		local px = val * (4 / 3)
		return px / state.get_base_font().size
	end,
	cm = function(val)
		return val * 0.0352778
	end,
	['in'] = function(val)
		return val * 0.0138889
	end,
	px = function(val)
		return val * (4 / 3)
	end,
	mm = function(val)
		return val * 0.352778
	end,
	pc = function(val)
		return val * 0.0833333
	end
}

converters.pc = {
	px = function(val)
		return val * 16 -- 1 pica = 16 pixels (typographical points)
	end,
	rem = function(val)
		local px = val * 16
		return px / state.get_base_font().size
	end,
	cm = function(val)
		return val * 0.423333 -- 1 pica = 0.423333 centimeters
	end,
	['in'] = function(val)
		return val * 0.1666667 -- 1 pica = 1/6 inch
	end,
	pt = function(val)
		return val * 12 -- 1 pica = 12 points
	end,
	mm = function(val)
		return val * 4.23333 -- 1 pica = 4.23333 millimeters
	end
}

converters.rem = {
	px = function(val)
		return val * state.get_base_font().size
	end,
	cm = function(val)
		local px = val * state.get_base_font().size
		return px * 0.0264583333
	end,
	['in'] = function(val)
		local px = val * state.get_base_font().size
		return px * 0.010417
	end,
	pt = function(val)
		local px = val * state.get_base_font().size
		return px * 0.74999943307122
	end,
	mm = function(val)
		local px = val * state.get_base_font().size
		return px * 0.264583333
	end,
	pc = function(val)
		local px = val * state.get_base_font().size
		return px * 0.0625
	end
}

converters.mm = {
	px = function(val)
		return val * 3.7795275591
	end,
	rem = function(val)
		local px = val * 3.7795275591
		return px / state.get_base_font().size
	end,
	cm = function(val)
		return val * 0.1
	end,
	['in'] = function(val)
		return val * 0.0393701
	end,
	pt = function(val)
		return val * 2.8346456693
	end,
	pc = function(val)
		return val * 0.2362204724
	end
}

converters.cm = {
	px = function(val)
		return val * 37.795275591
	end,
	rem = function(val)
		local px = val * 37.795275591
		return px / state.get_base_font().size
	end,
	mm = function(val)
		return val * 10
	end,
	['in'] = function(val)
		return val * 0.393701
	end,
	pt = function(val)
		return val * 28.346456693
	end,
	pc = function(val)
		return val * 2.3622047244
	end
}

converters['in'] = {
	px = function(val)
		return val * 96 -- 1 inch = 96 pixels (CSS standard)
	end,
	rem = function(val)
		local px = val * 96
		return px / state.get_base_font().size
	end,
	cm = function(val)
		return val * 2.54 -- 1 inch = 2.54 centimeters
	end,
	mm = function(val)
		return val * 25.4 -- 1 inch = 25.4 millimeters
	end,
	pt = function(val)
		return val * 72 -- 1 inch = 72 points (typographical points)
	end,
	pc = function(val)
		return val * 6 -- 1 inch = 6 picas
	end
}

local function hex_to_rgb(val)
	local hex = val:gsub("#", "")

	if #hex == 3 then
		local r = tonumber(hex:sub(1, 1) .. hex:sub(1, 1), 16)
		local g = tonumber(hex:sub(2, 2) .. hex:sub(2, 2), 16)
		local b = tonumber(hex:sub(3, 3) .. hex:sub(3, 3), 16)
		return string.format("rgb(%d, %d, %d)", r, g, b)
	end

	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 4), 16)
	local b = tonumber(hex:sub(5, 6), 16)
	return string.format("rgb(%d, %d, %d)", r, g, b)
end

---@param hsl string
local function hsl_to_rgb(hsl)
	local h, s, l = hsl:match(patterns.extract.hsl_extract)
	h = tonumber(h) / 360
	s = tonumber(s) / 100
	l = tonumber(l) / 100

	local function hue2rgb(p, q, t)
		if t < 0 then t = t + 1 end
		if t > 1 then t = t - 1 end
		if t < 1 / 6 then return p + (q - p) * 6 * t end
		if t < 1 / 2 then return q end
		if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
		return p
	end

	local r, g, b
	if s == 0 then
		r, g, b = l, l, l -- achromatic
	else
		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q
		r = hue2rgb(p, q, h + 1 / 3)
		g = hue2rgb(p, q, h)
		b = hue2rgb(p, q, h - 1 / 3)
	end

	return string.format("rgb(%d, %d, %d)", math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))
end

local function rgb_to_hex(rgb)
	local r, g, b = rgb:match(patterns.extract.rgb_extract)
	local hex = string.format("%02X%02X%02X", r, g, b)
	return hex
end

local function rgb_to_hsl(val)
	local r, g, b = val:match(patterns.extract.rgb_extract)
	r = tonumber(r) / 255
	g = tonumber(g) / 255
	b = tonumber(b) / 255

	local max = math.max(r, g, b)
	local min = math.min(r, g, b)
	local h, s, l = 0, 0, (max + min) / 2

	if max ~= min then
		local d = max - min
		s = l > 0.5 and d / (2 - max - min) or d / (max + min)
		if max == r then
			h = (g - b) / d + (g < b and 6 or 0)
		elseif max == g then
			h = (b - r) / d + 2
		elseif max == b then
			h = (r - g) / d + 4
		end
		h = h / 6
	end

	return string.format("hsl(%d, %d%%, %d%%)", h * 360, s * 100, l * 100)
end

converters.hex = {
	rgb = hex_to_rgb,
	hsl = function(val)
		local rgb = hex_to_rgb(val)
		return rgb_to_hsl(rgb)
	end
}

converters.rgb = {
	hex = rgb_to_hex,
	hsl = rgb_to_hsl,
}

converters.hsl = {
	rgb = hsl_to_rgb,
	hex = function(val)
		local rgb = hsl_to_rgb(val)
		return rgb_to_hex(rgb)
	end
}

local function get_converter(from, to, val)
	if converters[from] and converters[from][to] then
		return converters[from][to](val)
	else
		error("Converter from " .. from .. " to " .. to .. " not found")
	end
end

return get_converter
