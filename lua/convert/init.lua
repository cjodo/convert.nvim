local utils = require("convert.utils")
local ui = require("convert.ui.open_popup")
local events = require("convert.events")
local config = require("convert.config")

events.setup()

local M = {}

M.setup = function(opts)
	print("hello from setup")
	if opts then
		config.keymaps = opts.keymaps
	end
end

M.find_next = function()
	local cursor_pos = utils.get_cursor_pos()
	local bufnr = vim.api.nvim_get_current_buf()
	local current_win = vim.api.nvim_get_current_win()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true) -- All lines in current buffer
	local next_row = cursor_pos.row + 1                         -- next row

	for row = next_row, #lines, 1 do
		local line = lines[row]
		local found_unit = utils.find_unit_in_line(line, row)


		if found_unit ~= nil then
			vim.api.nvim_win_set_cursor(current_win, { row, found_unit.start_col - 1 })
			ui.open_win(found_unit)
			return
		end
	end
end

M.find_current = function()
	local cursor_pos = utils.get_cursor_pos()
	local current_win = vim.api.nvim_get_current_win()

	local current_line = vim.api.nvim_get_current_line()

	local found_unit = utils.find_unit_in_line(current_line, cursor_pos.row)

	if found_unit ~= nil then
		vim.api.nvim_win_set_cursor(current_win, { cursor_pos.row, found_unit.start_col - 1 })
		ui.open_win(found_unit)
	end
end

return M
