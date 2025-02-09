local M = {}

M.matchers = {
	px = "(%d+%.?%d*)px",
	rem = "(%d+%.?%d*)rem",
	em = "(%d+%.?%d*)em",
	['in'] = "(%d+%.?%d*)in", -- "in" is a reserved lua keyword
	ch = "(%d+%.?%d*)ch",
	mm = "(%d+%.?%d*)mm",
	cm = "(%d+%.?%d*)cm",
	pt = "(%d+%.?%d*)pt",
	pc = "(%d+%.?%d*)pc",
	rgb = 'rgb%(%d+, %d+, %d+%)',
	hex = "#(%x%x%x%x?%x?%x?%x?%x?)",
	hsl = 'hsl%(%d+, %d+%%, %d+%%%)',
	bin = '0b([01]+)',
	octal = '0o([0-7]+)',
	hexadecimal = '0x([%da-fA-F]+)',
}

M.extract = {
	rgb_extract = 'rgb%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*%)',
	hsl_extract = 'hsl%(%s*(%d+)%s*,%s*(%d+)%%%s*,%s*(%d+)%%%s*%)',
}

return M
