# convert.nvim

https://github.com/user-attachments/assets/46129dd1-35b0-41ce-a1d8-ead1922d8af4

## Dependencies
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim): UI Components

## Features
- Convert css units with one simple command
- track base font size on save to convert px to rems accurately (Single file support only)

## Installation: 
Use your favourite plugin manager

- Lazy: 
```lua
return {
  'cjodo/convert.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim'
  },
  keys = {
    { "<leader>cn", "<cmd>ConvertFindNext<CR>", desc = "Find next convertable unit" },
    { "<leader>cc", "<cmd>ConvertFindCurrent<CR>", desc = "Find convertable unit in current line" },
    { "<leader>ca", "<cmd>ConvertAll<CR>", desc = "Convert all of a specified unit" },
  },
}
```

## Usage
You can choose you're own custom keys for the ui menu
```lua
  config = function()
    local convert = require('convert')
    -- defaults
    convert.setup({
      keymaps = {
        focus_next = { "j", "<Down>", "<Tab>" },
        focus_prev = { "k", "<Up>", "<S-Tab>" },
        close = { "<Esc>", "<C-c>", 'qq' },
        submit = { "<CR>", "<Space>" },
      }
    })
  end

```


## Commands:

| Command             | Description                                                               |
|---------------------|---------------------------------------------------------------------------|
| :ConvertFindNext     | Finds the next convertible unit                                           |
| :ConvertFindCurrent  | Finds the convertible unit in the current line                            |
| :ConvertAll          | Converts all instances of a given unit to another                         |
