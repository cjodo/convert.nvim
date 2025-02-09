# convert.nvim

https://github.com/user-attachments/assets/46320296-58c1-408c-9fd5-e3ee757d9288

## Dependencies
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim): UI Components

## Features
- Convert css units with one simple command
- Base font supported for accurate rem conversion
- Convert all in a selection or entire buffer

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
        -- Add "v" to enable converting only a selected region
        { "<leader>ca", "<cmd>ConvertAll<CR>", mode = {"n", "v"} desc = "Convert all of a specified unit" },
    },
}
```
## Commands:

| Command              | Description                                                               |
|----------------------|---------------------------------------------------------------------------|
| :ConvertFindNext     | Finds the next convertible unit                                           |
| :ConvertFindCurrent  | Finds the convertible unit in the current line (starting from cursor)     |
| :ConvertAll          | Converts all instances in a buffer or visual mode selection of one unit to another of the same type (size, color)                         |

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
        },
        modes = { "color", "size", "numbers" } -- available conversion modes
    })
end

```
## Supported Conversions

### Size Units 📏  

| Unit | Description |
|------|------------|
| `px`  | Pixels |
| `rem` | Relative to root element |
| `cm`  | Centimeters |
| `in`  | Inches |
| `mm`  | Millimeters |
| `pt`  | Points |
| `pc`  | Picas |

---

### Color Formats 🎨  

| Format | Description |
|--------|------------|
| `rgb`  | Red-Green-Blue |
| `hex`  | Hexadecimal color code |
| `hsl`  | Hue-Saturation-Lightness |

---

### Number Systems 🔢  

| Format       | Description |
|-------------|------------|
| `bin`       | Binary |
| `hexadecimal` | Hexadecimal |
| `octal`     | Octal |

