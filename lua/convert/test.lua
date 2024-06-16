local utils = require("convert.utils")
local converters = require("convert.converters")
local patterns = require("convert.patterns")

local test_string = 'rgb(20, 20, 20)'

local r = utils.match_unit(test_string)

print(r)
