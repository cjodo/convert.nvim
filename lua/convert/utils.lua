local M = {}

local patterns = require('convert.patterns')

local units = patterns.matchers

M.get_cursor_pos = function()
	local r, c = unpack(vim.api.nvim_win_get_cursor(0))

	return {
		row = r,
		col = c
	}
end

---@param line string
M.match_unit = function(line)
	for unit, pattern in pairs(units) do
		local s, e, val = string.find(line, pattern)
		if s ~= nil and e ~= nil then
			if unit == 'rgb' or unit == 'hsl' then
				val = line:match(pattern)
			end
			return {
				unit = unit,
				val = val,
				pos = {
					start_col = s, -- start col
					end_col = e -- end col
				}
			}
		end
	end
end

M.find_unit_in_line = function(line, cursor_row)
	local unit = M.match_unit(line)
	if unit then
		return {
			unit = unit.unit,
			val = unit.val,
			row = cursor_row,
			start_col = unit.pos.start_col,
			end_col = unit.pos.end_col
		}
	end
	return nil
end

---@param num number
---@param numDecimalPlaces number
M.round = function(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

M.contains = function(table, value)
	for _, v in ipairs(table) do
		if v == value then
			return true
		end
	end
	return false
end

M.get_file_extension = function(url)
	return url:match("^.+(%..+)$")
end


M.merge = function (t1, t2)
	 local result = {}
    for _, v in ipairs(t1) do
        table.insert(result, v)
    end
    for _, v in ipairs(t2) do
        table.insert(result, v)
    end
    return result
end

return M
