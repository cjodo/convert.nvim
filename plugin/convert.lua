if vim.g.loaded_convert then
	return
end

vim.cmd("command! ConvertFindCurrent lua require('convert').find_current()")
vim.cmd("command! ConvertFindNext lua require('convert').find_next()")
vim.cmd("command! ConvertAll lua require('convert').convert_all()")
