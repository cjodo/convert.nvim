local utils = {}

local units = require('convert.patterns')

utils.get_cursor_pos = function ()
	local r, c = unpack(vim.api.nvim_win_get_cursor(0))

	return {
		row = r,
		col = c
	}
end

---@param line string
utils.match_unit = function (line)
	print(line)
	for unit, pattern in pairs(units) do
		local s, e, val = string.find(line, pattern)
		if s ~= nil and e ~= nil then
			print(unit, val)
			return {
				unit = unit,
				val = val,
				pos = {
					start_col = s,	-- start col
					end_col = e		-- end col
				}
			}
		end
	end
end

utils.find_unit_in_line = function (line, cursor_row)
	local unit = utils.match_unit(line)
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
utils.round = function (num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

return utils
