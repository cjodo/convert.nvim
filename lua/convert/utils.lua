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
	for unit, pattern in pairs(units) do
		local s, e = string.find(line, pattern)
		if s ~= nil and e ~= nil then
			local val = string.sub(line, s, e - #unit)
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

utils.get_base_font_size = function ()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

	for i = 1, #lines, 1 do
		
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

return utils
