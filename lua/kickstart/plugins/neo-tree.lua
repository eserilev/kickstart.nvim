-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>gs', ':Neotree git_status<CR>', desc = 'NeoTree changed files', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    -- The git_status source lists only the changed files. Enter opens the
    -- file and turns on the gitsigns inline diff: added lines green,
    -- removed lines red. Space t i turns the inline diff off again.
    git_status = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<cr>'] = 'open_inline_diff',
        },
      },
      commands = {
        open_inline_diff = function(state)
          require('neo-tree.sources.common.commands').open(state)
          local gs = require 'gitsigns'
          gs.toggle_linehl(true)
          gs.toggle_deleted(true)
          gs.toggle_word_diff(true)
        end,
      },
    },
  },
}
