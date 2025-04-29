local units = require('convert.patterns').matchers

local M = {}

---@class cursor_pos
---@field	row integer
---@field col integer

--- current cursor pos in active buffer
---@return cursor_pos
M.get_cursor_pos = function()
	local r, c = unpack(vim.api.nvim_win_get_cursor(0))
	---@type cursor_pos
	local pos = {
		row = r,
		col = c
	}

	return pos
end


---full matched string position
---@class matched_pos
---@field row integer | nil
---@field start_col integer
---@field end_col integer

---@class matched
---@field unit string
---@field val integer | string
---@field pos matched_pos

--- Matches line that satisfies any matcher from convert.patterns
---@param line string
---@return matched | nil
M.match_unit = function(line)
	for unit, pattern in pairs(units) do
		local s, e, val = string.find(line, pattern)

		if s ~= nil and e ~= nil then
			if unit == 'rgb' or unit == 'hsl' then
				val = line:match(pattern)
			end
			---@type matched
			return {
				unit = unit,
				val = val,
				pos = {
					row = nil,
					start_col = s, -- start col
					end_col = e -- end col
				}
			}
		end
	end
	return nil
end


---@param line string
---@param cursor_row number
---@return matched[] | nil
M.find_all_units_in_line = function(line, cursor_row)
	local results = {}
	local matched_unit = nil

	for unit, pattern in pairs(units) do
		local start_pos = 1
		while start_pos <= #line do
			local s, e, val = string.find(line, pattern, start_pos)
			if s == nil then break end

			if unit == 'rgb' or unit == 'hsl' then
				val = line:match(pattern, start_pos)
			end

			local num_val = tonumber(val)
			if num_val then
				-- If this is the first unit match, set it as the inferred from_unit
				if not matched_unit then
					matched_unit = unit
				end

				-- Only collect matches for the same inferred unit
				if unit == matched_unit then
					table.insert(results, {
						unit = unit,
						val = num_val,
						pos = {
							row = cursor_row,
							start_col = s,
							end_col = e,
						}
					})
				end
			end

			start_pos = e + 1
		end

		if matched_unit then
			break -- only process one unit type (inferred one)
		end
	end

	if #results > 0 then
		return results
	end

	return nil
end


---@return matched[] | nil
M.find_unit_in_line = function(line, cursor_row)
	local unit = M.match_unit(line)
	if unit then
		return {
			unit = unit.unit,
			val = unit.val,
			pos = {
				row = cursor_row,
				start_col = unit.pos.start_col,
				end_col = unit.pos.end_col
			}
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


---@class selection 
---@field start_row integer
---@field lines string[]
---@return selection | nil
M.get_selection = function ()
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1

	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)

	if #lines <= 1 then
		return nil
	end

	lines[1] = string.sub(lines[1], s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	return {
		start_row = s_start[2],
		lines = lines
	}
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

---Converts a base num to a base^to num
---@param num integer
---@param base integer
---@param to integer
---@return string | nil
M.num_convert = function (num, base, to)
	local decimal = tonumber(num, base)
	if not decimal then
		error("invalid base " .. base .. " string")
		return nil
	end

	local ret = ""
	while decimal > 0 do
		local remainder = decimal % to
		ret = remainder .. ret
		decimal = math.floor(decimal / to)
	end

	return ret == "" and "0" or ret
end

return M
