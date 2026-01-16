local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

local M = {}

M.actions_picker = function()
  local actions_list = {
    {
      name = "Find current conversion",
      fn = require("convert").find_current,
    },
    {
      name = "Find next conversion",
      fn = require("convert").find_next,
    },
    {
      name = "Convert all",
      fn = require("convert").convert_all,
    },
  }

  pickers.new({}, {
    prompt_title = "Convert",
    finder = finders.new_table({
      results = actions_list,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        selection.value.fn()
      end)
      return true
    end,
  }):find()
end

return M

