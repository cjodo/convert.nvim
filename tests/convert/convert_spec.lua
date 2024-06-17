local utils = require("convert.utils")

local rgb_string = "rgb(20, 20, 20)"
local hex_string = "#feefff"

describe("Pattern matching", function()
	it("Should Match rgb string", function()
		assert.are.equal("rgb(20, 20, 20)", utils.match_unit(rgb_string).val)
		assert.are.equal("rgb", utils.match_unit(rgb_string).unit)
	end)

	it("Should Match hex string", function()
		assert.are.equal("feefff", utils.match_unit(hex_string).val)
		assert.are.equal("hex", utils.match_unit(hex_string).unit)
	end)
end)
