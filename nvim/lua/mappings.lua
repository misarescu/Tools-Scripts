require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- undotree setup
map('n', '<leader>uu', ':UndotreeToggle<CR>', { desc = 'Undo tree toggle' })
map('n', '<leader>up', ':UndotreePersistUndo<CR>', { desc = 'Undo tree persist' })
map('n', '<C-d>', '<C-d>zz', { desc = 'Half page down and center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Half page up and center' })
map('n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = 'Toggle comment' })
map('n', '<leader>p', '"_dP', { desc = 'Paste without overwrite' })
map('n', '<leader>s', ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = 'Search and replace word under cursor' })
map('n', 'J', 'mzJ`z', { desc = 'Join lines and keep cursor position' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })
map('n', 'Q', '<nop>', { desc = 'Disable Ex mode' })
map('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
map('n', 'x', '"_x', { desc = 'Delete character but don\'t copy to buffer' })
