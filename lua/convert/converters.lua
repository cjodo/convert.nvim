local parser = require("convert.parsers.parser")
local utils = require("convert.utils")

local file_path = vim.fn.expand('%')
local cursor = utils.get_cursor_pos()

local base_font_size = parser.base_font(file_path, cursor.row).size or 16

local rgb_extract = 'rgb%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*%)'

local update = function()
    base_font_size = parser.base_font(file_path, cursor.row + 1).size
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
    pattern = { "*.css" },
    callback = function()
        update()
        print(base_font_size)
    end
})

---@return number
local converters = { -- pattern is like this: converters[from][to](value_from)
    px = {
        ---@param val integer
        rem = function(val)
            return val / base_font_size
        end,
        em = function(val)
            return val / base_font_size -- TODO: Not quite how this works but close enough for now
        end,
        cm = function(val)
            return val * 0.0264583333
        end,
        ['in'] = function(val)
            return val * 0.010417
        end,
        pt = function(val)
            return val * 0.74999943307122
        end
    },
    pt = {
        rem = function(val)
            local px = val * (4 / 3)
            return px / base_font_size
        end,
        em = function(val)
            local px = val * (4 / 3)
            return px / base_font_size
        end,
        cm = function(val)
            return val * 0.0352778
        end,
        ['in'] = function(val)
            return val * 0.0138889
        end,
        px = function(val)
            return val * (4 / 3)
        end
    },
    rem = {
        px = function(val)
            return val * base_font_size
        end,
        em = function(val)
            return val -- Assuming 1rem = 1em for simplicity
        end,
        cm = function(val)
            local px = val * base_font_size
            return px * 0.0264583333
        end,
        ['in'] = function(val)
            local px = val * base_font_size
            return px * 0.010417
        end,
        pt = function(val)
            local px = val * base_font_size
            return px * 0.74999943307122
        end
    },
    em = {
        px = function(val)
            return val * base_font_size -- Assuming 1em = base_font_size in pixels
        end,
        rem = function(val)
            return val -- Assuming 1em = 1rem for simplicity
        end,
        cm = function(val)
            local px = val * base_font_size
            return px * 0.0264583333
        end,
        ['in'] = function(val)
            local px = val * base_font_size
            return px * 0.010417
        end,
        pt = function(val)
            local px = val * base_font_size
            return px * 0.74999943307122
        end
    },
    mm = {
        px = function(val)
            return val * 3.7795275591
        end,
        rem = function(val)
            local px = val * 3.7795275591
            return px / base_font_size
        end,
        em = function(val)
            local px = val * 3.7795275591
            return px / base_font_size
        end,
        cm = function(val)
            return val * 0.1
        end,
        ['in'] = function(val)
            return val * 0.0393701
        end,
        pt = function(val)
            return val * 2.8346456693
        end
    },
    cm = {
        px = function(val)
            return val * 37.795275591
        end,
        rem = function(val)
            local px = val * 37.795275591
            return px / base_font_size
        end,
        em = function(val)
            local px = val * 37.795275591
            return px / base_font_size
        end,
        mm = function(val)
            return val * 10
        end,
        ['in'] = function(val)
            return val * 0.393701
        end,
        pt = function(val)
            return val * 28.346456693
        end
    },
    ['in'] = {
        px = function(val)
            return val * 96 -- 1 inch = 96 pixels (CSS standard)
        end,
        rem = function(val)
            local px = val * 96
            return px / base_font_size
        end,
        em = function(val)
            local px = val * 96
            return px / base_font_size
        end,
        cm = function(val)
            return val * 2.54 -- 1 inch = 2.54 centimeters
        end,
        mm = function(val)
            return val * 25.4 -- 1 inch = 25.4 millimeters
        end,
        pt = function(val)
            return val * 72 -- 1 inch = 72 points (typographical points)
        end
    },
    -- COLORS
    hex = {
        rgb = function(val)
            local hex = val:gsub("#", "")
            local r = tonumber(hex:sub(1, 2), 16)
            local g = tonumber(hex:sub(3, 4), 16)
            local b = tonumber(hex:sub(5, 6), 16)
            return string.format("rgb(%d, %d, %d)", r, g, b)
        end,
        hsl = function(val)
            local rgb = converters.hex.rgb(val)
            return converters.rgb.hsl(rgb)
        end
    },
    rgb = {
        hex = function(val)
            local r, g, b = val:match(rgb_extract)
            print(r, g, b)
            local hex = string.format("%02X%02X%02X", r, g, b)
            return hex
        end,
        hsl = function(val)
            local r, g, b = val:match("rgb%((%d+),%s*(%d+),%s*(%d+)%)")
            r = tonumber(r) / 255
            g = tonumber(g) / 255
            b = tonumber(b) / 255

            local max = math.max(r, g, b)
            local min = math.min(r, g, b)
            local h, s, l = 0, 0, (max + min) / 2

            if max ~= min then
                local d = max - min
                s = l > 0.5 and d / (2 - max - min) or d / (max + min)
                if max == r then
                    h = (g - b) / d + (g < b and 6 or 0)
                elseif max == g then
                    h = (b - r) / d + 2
                elseif max == b then
                    h = (r - g) / d + 4
                end
                h = h / 6
            end

            return string.format("hsl(%d, %d%%, %d%%)", h * 360, s * 100, l * 100)
        end
    },
    hsl = {
        rgb = function(val)
            local h, s, l = val:match("hsl%((%d+),%s*(%d+)%%,%s*(%d+)%%%)")
            h = tonumber(h) / 360
            s = tonumber(s) / 100
            l = tonumber(l) / 100

            local function hue2rgb(p, q, t)
                if t < 0 then t = t + 1 end
                if t > 1 then t = t - 1 end
                if t < 1 / 6 then return p + (q - p) * 6 * t end
                if t < 1 / 2 then return q end
                if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
                return p
            end

            local r, g, b
            if s == 0 then
                r, g, b = l, l, l -- achromatic
            else
                local q = l < 0.5 and l * (1 + s) or l + s - l * s
                local p = 2 * l - q
                r = hue2rgb(p, q, h + 1 / 3)
                g = hue2rgb(p, q, h)
                b = hue2rgb(p, q, h - 1 / 3)
            end

            return string.format("rgb(%d, %d, %d)", math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))
        end,
        hex = function(val)
            local rgb = converters.hsl.rgb(val)
            return converters.rgb.hex(rgb)
        end
    }
}

return converters
