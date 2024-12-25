local M = {}

local selectors = {
	"body%s*{",
	":root%s*{",
	"%*%s*{"
}

local font_size_pattern = "font%-size:%s*([%d%.]+)([pxrem]*)"

---@class base_font
---@field size integer
---@field unit string

---@return base_font
M.base_font = function(cursor_row) -- if no font is found until cursor pos, then no more checks are needed
	local path = vim.fn.expand("%")
	local file = io.open(path, 'r')

	if not file then
		return {nil}
	end

	---@type base_font
	local base_font = {
		size = 16,
		unit = "px"
	}


	local in_block = false
	local block_content = ""

	local current_row = 1

	for line in file:lines() do
		current_row = current_row + 1

		if current_row > cursor_row then
			file:close()
			return base_font
		end

		if in_block then
			---@type string
			block_content = block_content .. line
			if line:find("}") then
				local size, unit = block_content:match(font_size_pattern)
				if size and unit then
					-- can't return until cursor row is reached. could be others defined below
					base_font.size = size
					base_font.unit = unit
				end
				in_block = false
				block_content = ""
			end
		else
			for _, selector in ipairs(selectors) do
				if line:find(selector) then
					in_block = true
					block_content = line
					break
				end
			end
		end
	end

	return base_font
end

return M
