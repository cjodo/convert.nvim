# convert.nvim
![DEMO](https://asciinema.org/a/PBfD6Sl9UtZekedR4fuMNai6n)
## Dependencies
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim): UI Components

## Features
- Convert css units with one simple command
- track base font size to convert px to rems effortlessly (Single file support only)

## Installation: 
Use your favourite plugin manager

- Lazy: 
```lua
return {
  'cjodo/convert.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim'
  },
  config = function()
    vim.keymap.set("n", "<leader>cn", "<cmd>ConvertFindNext<CR>", { desc = "Find next convertable unit" })
    vim.keymap.set("n", "<leader>cc", "<cmd>ConvertFindCurrent<CR>", { desc = "Find convertable unit in current line" })
  end
}
```

## Usage

- There are only two commands, ```:ConvertFindCurrent``` & ```:ConvertFindNext```
- Convert find next will look for the next convertable unit in the file
- Convert find current will look for a unit on the current line
