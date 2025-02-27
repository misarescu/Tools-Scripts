-- telescope setup
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
-- theme telescope
require('telescope').setup({
  pickers = {
    find_files = {
      theme = 'dropdown'
    },
    live_grep = {
      theme = 'dropdown'
    },
    buffers = {
      theme = 'dropdown'
    },
    help_tags = {
      theme = 'dropdown'
    },

  },
})

-- undotree setup
vim.keymap.set('n', '<leader>uu', ':UndotreeToggle<CR>', { desc = 'Undo tree toggle' })
vim.keymap.set('n', '<leader>up', ':UndotreePersistUndo<CR>', { desc = 'Undo tree persist undo' })

-- other setup
local which_key = require("which-key")
local non_lsp_mappings = {
  { "<C-d>",     "<C-d>zz",                                              desc = "Half page down and center" },
  { "<C-u>",     "<C-u>zz",                                              desc = "Half page up and center" },
  { "<leader>/", "<Plug>(comment_toggle_linewise_current)",              desc = "Toggle comment" },
  { "<leader>e", ":Ex<CR>",                                              desc = "Open file explorer" },
  { "<leader>p", '"_dP',                                                 desc = "Paste without overwrite" },
  { "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", desc = "Search and replace word under cursor" },
  { "<leader>t", ":Today<CR>",                                           desc = "Open today's note" },
  { "J",         "mzJ`z",                                                desc = "Join lines and keep cursor position" },
  { "N",         "Nzzzv",                                                desc = "Previous search result and center" },
  { "Q",         "<nop>",                                                desc = "Disable Ex mode" },
  { "n",         "nzzzv",                                                desc = "Next search result and center" },
  { "x",         '"_x',                                                  desc = "Delete character but don't copy to buffer" },
}

which_key.add(non_lsp_mappings)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, 'gF', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', 'gEx', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = event.buf,
      callback = function()
        vim.lsp.buf.format { async = false, id = event.data.client_id }
      end,
    })
  end,
})

-- DAP keymaps
local dap, dapui = require('dap'), require('dapui')
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'continue' })
vim.keymap.set('n', '<leader>dsn', dap.step_over, { desc = 'step over' })
vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = 'step into' })
vim.keymap.set('n', '<leader>dso', dap.step_out, { desc = 'step out' })
vim.keymap.set('n', '<Leader>dbb', dap.toggle_breakpoint, { desc = 'toggle breakpoint' })
vim.keymap.set('n', '<Leader>dbB', dap.set_breakpoint, { desc = 'set breakpoint' })
vim.keymap.set('n', '<Leader>dbl',
  function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'log point' })
vim.keymap.set("n", "<leader>de", function() dapui.elements.watches.add(vim.fn.expand('<cword>')) end, {desc='add element to watch', silent = true })
vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = 'repl open' })
vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = 'run last' })
vim.keymap.set('n', '<Leader>dR', dap.run, { desc = 'run' })
vim.keymap.set('n', '<Leader>dw', dapui.open, { desc = 'open' })
vim.keymap.set('n', '<Leader>dW', dapui.close, { desc = 'close' })
