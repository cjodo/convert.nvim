--FUNCK REGEX
local M = {
	px = '[0-9]+%.?[0-9]*px', -- %.? in the pattern allows for optional decimal points
	rem = '[0-9]+%.?[0-9]*rem',
	em = '[0-9]+%.?[0-9]*em',
	pt = '[0-9]+%.?[0-9]*pt',
	['in'] = '[0-9]+%.?[0-9]*in',
	cm = '[0-9]+%.?[0-9]*cm',
	mm = '[0-9]+%.?[0-9]*mm',
	-- TODO: color handling
	rgb = 'rgb%(%s*[0-9]+%s*,%s*[0-9]+%s*,%s*[0-9]+%s*%)',
	hex = '#%x%x%x%x%x%x',
	hsl = 'hsl%(%s*[0-9]+%s*,%s*[0-9]+%%%s*,%s*[0-9]+%%%s*%)'

}
return M
