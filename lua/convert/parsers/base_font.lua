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

---returns base font in px. Parsed from body, :root, *, selectors only
---@return base_font
M.base_font = function(cursor_row) -- if no font is found until cursor pos, then no more checks are needed
	local bufnr = 			vim.api.nvim_get_current_buf()
	local lines = 			vim.api.nvim_buf_get_lines(bufnr, 0, -1, true) -- All lines in current buffer

	---@type base_font
	local base_font = {
		size = 16,
		unit = "px"
	}


	local in_block = false
	local block_content = ""

	for current_row = 1, #lines, 1 do
		local line = lines[current_row]

		if current_row > cursor_row then
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
