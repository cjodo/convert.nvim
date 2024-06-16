# convert.nvim

## Installation: 
Use your favourite plugin manager

- With Lazy: 
```lua
return {
  'cjodo/convert.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim'
  },
  config = function()
    vim.keymap.set("n", "<leader>cn", "<cmd>ConvertFindNext<CR>", { desc = "Find next convertable unit" })
    vim.keymap.set("n", "<leader>cc", "<cmd>ConvertFindCurrent<CR>", { desc = "Find convertable unit" })
  end
}
```

