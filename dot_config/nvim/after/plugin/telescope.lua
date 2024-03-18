local builtin = require('telescope.builtin') local set = require("user.common").set

set('n', '<leader>ff', builtin.find_files, "Files")
set('n', '<leader>fg', builtin.live_grep, "Search")
set('n', '<leader>fb', builtin.buffers, "Buffers")
set('n', '<leader>fh', builtin.help_tags, "Help")
set('n', '<leader>fr', builtin.registers, "Registers")
set('n', '<leader>fm', builtin.marks, "Marks")
set('n', '<leader>fo', builtin.oldfiles, "Old Files")


require("telescope").setup({
  defaults = {
    layout_config = {
      prompt_position = "top",
    },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    sorting_strategy = "ascending",
    scroll_strategy = nil,
    path_display = { shorten = { len= 3, exclude = {-1, -2, -3} } },
    dynamic_preview_title = true,
    file_ignore_patterns = { "messages.json$", "%.dump$", "%.svg$" , "node_modules/"},
    mappings = {
      n = {
        ['<c-d>'] = require('telescope.actions').delete_buffer
      },
      i = {
        ["<C-h>"] = "which_key",
        ['<c-d>'] = require('telescope.actions').delete_buffer
      }
    }
  }})
