local utils = require("convert.utils")
local ui = require("convert.ui.open_popup")
local config = require("convert.config")
local split = require("convert.ui.open_split")


local M = {}

M.setup = function(opts)
	if opts.keymaps then
		config.keymaps = opts.keymaps
	end
end

M.find_next = function()
	local cursor_pos = 	utils.get_cursor_pos()
	local bufnr = 			vim.api.nvim_get_current_buf()
	local lines = 			vim.api.nvim_buf_get_lines(bufnr, 0, -1, true) -- All lines in current buffer
	local current_win = vim.api.nvim_get_current_win()
	local next_row = 		cursor_pos.row + 1

	for row = next_row, #lines, 1 do
		local line = lines[row]
		local found_units = utils.find_all_units_in_line(line, row)


		if found_units ~= nil then
			vim.api.nvim_win_set_cursor(current_win, { row, found_units[1].pos.start_col - 1 })
			ui.open_win(found_units)
			return
		end
	end
end

M.find_current = function()
	local cursor_pos = utils.get_cursor_pos()
	local current_win = vim.api.nvim_get_current_win()

	local current_line = vim.api.nvim_get_current_line()

	local line = current_line:sub(0, #current_line)

	line = string.rep(" ", #current_line - #line) .. line

	local found_units = utils.find_all_units_in_line(line, cursor_pos.row)

	if found_units ~= nil and #found_units > 0 then
		vim.api.nvim_win_set_cursor(current_win, { cursor_pos.row, found_units[1].pos.start_col - 1 })
		ui.open_win(found_units)
	end
end

M.convert_all = function()
	split.open_split(config)
end

return M
