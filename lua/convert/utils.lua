local utils = {}

utils.get_cursor_pos = function ()
	local r, c = unpack(vim.api.nvim_win_get_cursor(0))

	return {
		row = r,
		col = c
	}
end

-- @param line string
-- @param line table
utils.match_unit = function (line, units)

	for unit, pattern in pairs(units) do
		local s, e = string.find(line, pattern)

		if s ~= nil and e ~= nil then
			return {
				unit = unit,
				pos = {
					s = s,	-- start col
					e = e		-- end col
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

return utils
