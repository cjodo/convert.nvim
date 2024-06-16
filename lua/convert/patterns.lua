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
	-- TODO: better color handling
	rgb = 'rgb%(%d+, %d+, %d+%)',
	hex = "#(%x%x%x%x?%x?%x?%x?%x?)",
	hsl = 'hsl%(%s*[0-9]+%s*,%s*[0-9]+%%%s*,%s*[0-9]+%%%s*%)'

}

return M
