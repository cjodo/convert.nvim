local config = {}

-- set defaults
config.keymaps = {
	focus_next = { "j", "<Down>", "<Tab>" },
	focus_prev = { "k", "<Up>", "<S-Tab>" },
	close = { "<Esc>", "<C-c>", 'qq' },
	submit = { "<CR>", "<Space>" },
}

return config
