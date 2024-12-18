local M = {}

local selectors = {
	"body%s*{",
	":root%s*{",
	"%*%s*{"
}

local font_size_pattern = "font%-size:%s*([%d%.]+)([pxrem]*)"


---@return table | nil
M.base_font = function(file_path, cursor_row) -- if no font is found until cursor pos, then no more checks are needed
	local file = io.open(file_path, 'r')

	if not file then
		error("file not found")
		return nil
	end

	local in_block = false
	local block_content = ""

	local size = 16
	local unit = 'px'

	local current_row = 1

	for line in file:lines() do
		current_row = current_row + 1

		if current_row > cursor_row then
			file:close()
			return {
				size = size,
				unit = unit
			}
		end

		if in_block then
			---@type string
			block_content = block_content .. line
			if line:find("}") then
				size, unit = block_content:match(font_size_pattern)
				if size and unit then
					-- can't return until cursor row is reached. could be others defined below
					size = size
					unit = unit
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

	print(size)
	return {
		size = size,
		unit = 'px'
	}
end

return M
