local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event
local utils = require("convert.utils")

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
      Menu.item('pt'),
    },
    max_width = 100,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>"  },
      focus_prev = { "k", "<Up>", "<S-Tab>"  },
      close = { "<Esc>", "<C-c>"  },
      submit = { "<CR>", "<Space>"  },
    },
    on_close = function ()
      print("Closed")
    end,
    on_submit = function (item)
      print("Submitted", item.text)
    end
  })

  menu:mount()

end

return M
