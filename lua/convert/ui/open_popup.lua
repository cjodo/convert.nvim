local Menu = require("nui.menu")
local calculator = require("convert.calculator")
local utils = require("convert.utils")
local config = require("convert.config")

local size_units = {
	'px',
	'rem',
	'cm',
	'in',
	'mm',
	'pt',
	'pc'
}

local color_units = {
	'rgb',
	'hex',
	'hsl'
}

local color_menu = {
	Menu.item('rgb'),
	Menu.item('hex'),
	Menu.item('hsl'),
}

local size_menu = {
	Menu.item('px'),
	Menu.item('rem'),
	Menu.item('cm'),
	Menu.item('in'),
	Menu.item('mm'),
	Menu.item('pt'),
	Menu.item('pc'),
}

local M = {}

--- Opens popup window for convert in a single line
---@param found_units matched[]
M.open_win = function(found_units)
	if not found_units or #found_units == 0 then return end

	local from_unit = found_units[1].unit
	local from_val = found_units[1].val

	local lines = nil

	if utils.contains(color_units, from_unit) then
		lines = color_menu
	elseif utils.contains(size_units, from_unit) then
		lines = size_menu
	else
		return
	end

	local popup_opts = {
		relative = "cursor",
		position = {
			row = 2,
			col = 1,
		},
		size = {
			width = 40,
			height = #lines,
		},
		border = {
			style = "rounded",
			text = {
				top = "[Convert " .. from_val .. " To]",
				top_align = "center"
			},
		},
		buf_options = {
			modifiable = false,
			readonly = true,
		},
		win_options = {
			winhighlight = "Normal:Normal"
		}
	}
	local menu = Menu(popup_opts, {
		lines = lines,

		max_width = 100,
		keymap = config.keymaps,
		on_submit = function(item)
			local to_unit = item.text
			local bufnr = 0

			for i = #found_units, 1, -1 do
				local match = found_units[i]
				if match.unit == from_unit then
					local converted = calculator.convert(from_unit, to_unit, match.val)
					vim.api.nvim_buf_set_text(
						bufnr,
						match.pos.row - 1,
						match.pos.start_col - 1,
						match.pos.row - 1,
						match.pos.end_col,
						{ converted }
					)
				end
			end

			-- Move cursor to end of last converted unit
			local last = found_units[#found_units]
			vim.api.nvim_win_set_cursor(0, { last.pos.row, last.pos.end_col + #to_unit })
		end
	})

	menu:mount()
end

return M
