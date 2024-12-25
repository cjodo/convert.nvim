local M = {}

M.base_font = {
	size = 16,
	unit = 'px',
}

---@param size number
---@param unit string
M.set_base_font = function(size, unit)
	M.base_font.size = size
	M.base_font.unit = unit
end

M.get_base_font = function()
	return M.base_font
end

return M
