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

M.open_win = function(found_unit)
  local lines = nil

  if utils.contains(color_units, found_unit.unit) then
    lines = color_menu
  end

  if utils.contains(size_units, found_unit.unit) then
    lines = size_menu
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
        top = "[Convert " .. found_unit.val .. " To]",
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
      local from_unit = found_unit.unit
      local to_unit = item.text
      local from_val = found_unit.val
      local converted = calculator.convert(from_unit, to_unit, from_val)
      vim.api.nvim_buf_set_text(0, found_unit.row - 1, found_unit.start_col - 1, found_unit.row - 1, found_unit.end_col,
        { converted })
    end
  })

  menu:mount()
end

return M
