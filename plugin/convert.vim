if exists("g:loaded_convert")
		finish
endif

command! ConvertFindCurrent lua require('convert').find_current()
command! ConvertFindNext lua require('convert').find_next()
