if exists("g:loaded_convert")
		finish
endif

command! ConvertFindNext lua require('convert').find_next()
