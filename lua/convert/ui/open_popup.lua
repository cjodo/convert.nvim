local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
local calculator = require("convert.calculator")

local M = {}

M.open_win = function (found_unit)
  local popup_opts = {
    relative = "cursor",
    position = {
      row = 2,
      col = 1,
    },
    size = {
      width = 30,
      height = 6,
    },
    border = {
      style = "rounded",
      text = {
        top = "[Convert " .. found_unit.val .. found_unit.unit .. " To]",
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
    lines = {
      Menu.item('px'),
      Menu.item('rem'),
      Menu.item('em'),
      Menu.item('cm'),
      Menu.item('inch'),
      Menu.item('rgb'),
      Menu.item('hex'),
      Menu.item('hsl'),
    },
    max_width = 100,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>"  },
      focus_prev = { "k", "<Up>", "<S-Tab>"  },
      close = { "<Esc>", "<C-c>", 'qq' },
      submit = { "<CR>", "<Space>"  },
    },
    on_submit = function (item)
      local from_unit = found_unit.unit
      local to_unit = item.text
      local from_val = found_unit.val
      local converted = calculator.convert(from_unit, to_unit, from_val) .. to_unit
      vim.api.nvim_buf_set_text(0, found_unit.row - 1, found_unit.start_col - 1, found_unit.row - 1, found_unit.end_col, {converted} )
    end
  })

  menu:mount()

end

return M
