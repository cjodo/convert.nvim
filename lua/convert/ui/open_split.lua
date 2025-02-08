local Layout = require("nui.layout")
local Menu = require("nui.menu")
local convert_all = require("convert.convert_all")

local units_menu = {
  Menu.separator('Colors', {
    char = '-',
    text_align = 'left'
  }),
  Menu.item('rgb'),
  Menu.item('hex'),
  Menu.item('hsl'),
  Menu.separator('Size', {
    char = '-',
    text_align = 'left'
  }),
  Menu.item('px'),
  Menu.item('rem'),
  Menu.item('cm'),
  Menu.item('in'),
  Menu.item('mm'),
  Menu.item('pt'),
  Menu.item('pc'),
  Menu.separator('Numbers', {
    char = '-',
    text_align = 'left'
  }),
  Menu.item('bin'),
  Menu.item('hexadecimal'),
  Menu.item('octal'),
}

local left_options = {
  enter = true,
  border = {
    style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    text = {
      top = "[Origin]",
      top_align = "center"
    },
  },
}

local right_options = {
  enter = false,
  focusable = true,
  border = {
    style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    text = {
      top = "[To Unit]",
      top_align = "center"
    },
  },
}

local origin_unit = nil
local to_unit = nil

local M = {}

M.open_split = function(config)
  local right_menu = Menu(right_options, {
    lines = units_menu,
    keymap = config.keymaps,
    on_submit = function(item)
      if origin_unit == nil then
        error("Origin unit not defined")
      else
        to_unit = item.text

        local bufnr = vim.api.nvim_get_current_buf()
        convert_all(bufnr, origin_unit, to_unit)
      end
    end
  })

  local left_menu = Menu(left_options, {
    lines = units_menu,
    keymap = config.keymaps,
    on_change = function(item)
      origin_unit = item.text
    end,
    on_submit = function(item)
      origin_unit = item.text
    end
  })

  local layout = Layout(
    {
      position = "50%",
      size = {
        width = 80,
        height = #units_menu,
      },
    },
    Layout.Box({
      Layout.Box(left_menu, { size = "50%" }),
      Layout.Box(right_menu, { size = "50%" }),
    }, { dir = "row" })
  )

  layout:mount()

  vim.keymap.set('n', "<CR>", function()
    vim.api.nvim_set_current_buf(right_menu.bufnr)
  end, { buffer = left_menu.bufnr })
end

return M
