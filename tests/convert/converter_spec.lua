local converters = require("lua/convert.converters")

local rgb        = "rgb(20, 20, 20)"
local hsl        = "hsl(0, 0%, 7%)"
local hex        = "#141414"

describe("Unit conversions", function()
	it("Should convert colors", function()
		assert.are.equal(rgb, converters['hex']['rgb'](hex))
	end)
end)
