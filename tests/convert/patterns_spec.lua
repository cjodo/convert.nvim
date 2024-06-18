local utils = require("lua/convert.utils")

local rgb   = "rgb(20, 20, 20)"
local hsl   = "hsl(200, 30%, 30%)"
local hex   = "#feefff"
local px    = "20px"
local rem   = "1rem"
local cm    = "20cm"
local mm    = "20mm"
local pt    = "20pt"

describe("Pattern matching", function()
	it("Should Match rgb ", function()
		assert.are.equal("rgb(20, 20, 20)", utils.match_unit(rgb).val)
		assert.are.equal("rgb", utils.match_unit(rgb).unit)
	end)

	it("Should Match hex ", function()
		assert.are.equal("feefff", utils.match_unit(hex).val)
		assert.are.equal("hex", utils.match_unit(hex).unit)
	end)

	it("Should Match hsl ", function()
		assert.are.equal(hsl, utils.match_unit(hsl).val)
		assert.are.equal("hsl", utils.match_unit(hsl).unit)
	end)

	it("Should Match px ", function()
		assert.are.equal("20", utils.match_unit(px).val)
		assert.are.equal("px", utils.match_unit(px).unit)
	end)

	it("Should Match cm ", function()
		assert.are.equal("20", utils.match_unit(cm).val)
		assert.are.equal("cm", utils.match_unit(cm).unit)
	end)

	it("Should Match mm ", function()
		assert.are.equal("20", utils.match_unit(mm).val)
		assert.are.equal("mm", utils.match_unit(mm).unit)
	end)

	it("Should Match in", function()
		assert.are.equal("20", utils.match_unit("20in").val)
		assert.are.equal("in", utils.match_unit("20in").unit)
	end)

	it("Should Match pt ", function()
		assert.are.equal("20", utils.match_unit(pt).val)
		assert.are.equal("pt", utils.match_unit(pt).unit)
	end)
end)
