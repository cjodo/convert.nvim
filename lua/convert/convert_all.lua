local utils = require("convert.utils")
local calculator = require("convert.calculator")
local units = require("convert.units")

local convert_all = function(bufnr, from, to)
  local from_type = nil
  local to_type = nil

  if utils.contains(units.size_units, from) then
    from_type = 'size'
  elseif utils.contains(units.color_units, from) then
    from_type = 'color'
  elseif utils.contains(units.number_units, from) then
    from_type = 'number'
  end

  if utils.contains(units.size_units, to) then
    to_type = 'size'
  elseif utils.contains(units.color_units, to) then
    to_type = 'color'
  elseif utils.contains(units.number_units, to) then
    to_type = 'number'
  end

  if from_type ~= to_type then
    vim.notify("Cannot convert between incompatible types: " .. from_type .. " and " .. to_type, vim.log.levels.ERROR)
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for row, line in ipairs(lines) do
    local all_units = utils.find_all_units_in_line(line, row)
    if all_units ~= nil and #all_units > 0 then
      -- Work backward to avoid messing up positions
      for i = #all_units, 1, -1 do
        local found = all_units[i]
        if found.unit == from then
          local converted = calculator.convert(from, to, found.val)
          vim.api.nvim_buf_set_text(
            bufnr,
            found.pos.row - 1,
            found.pos.start_col - 1,
            found.pos.row - 1,
            found.pos.end_col,
            { converted }
          )
        end
      end
    end
  end
end


return convert_all
