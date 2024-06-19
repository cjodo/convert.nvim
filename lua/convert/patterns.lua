--FUNCK REGEX
local M = {
	px = "(%d+%.?%d*)px",
	rem = "(%d+%.?%d*)rem",
	em = "(%d+%.?%d*)em",
	['in'] = "(%d+%.?%d*)in",
	ch = "(%d+%.?%d*)ch",
	mm = "(%d+%.?%d*)mm",
	cm = "(%d+%.?%d*)cm",
	pt = "(%d+%.?%d*)pt",
	pc = "(%d+%.?%d*)pc",
	rgb = 'rgb%(%d+, %d+, %d+%)',
	hex = "#(%x%x%x%x?%x?%x?%x?%x?)",
	hsl = 'hsl%(%d+, %d+%%, %d+%%%)',
	rgb_extract = 'rgb%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*%)',
	hsl_extract = 'hsl%(%s*(%d+)%s*,%s*(%d+)%%%s*,%s*(%d+)%%%s*%)',
}

return M
