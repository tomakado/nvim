local g = vim.g
local cmd = vim.cmd
local map = require('utils').map

map('n', '<space>', '<nop')
g.mapleader = '<Space>'
--map('n', '<space>', '<leader>', { noremap = false })
cmd [[map <space> <leader>]]

-- Telescope
map('n', '<leader>sf', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍 <cr>')
map('n', '<leader>s', '<cmd>Telescope live_grep prompt_prefix=🔍 <cr>')
map('n', '<leader>sb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>sr', '<cmd>Telescope oldfiles<cr>')
map('n', '<leader>slr', '<cmd>Telescope lsp_references<cr>')
map('n', '<leader>sli', '<cmd>Telescope lsp_implementations<cr>')
map('n', '<leader>sld', '<cmd>Telescope diagnostics bufnr=0<cr>')

-- Neotree
map('n', '<leader>fe', '<cmd>Neotree toggle<cr>')

-- Go Debugger
map('n', '<leader>d', '<cmd>GoDebug<cr>')
map('n', '<leader>dc', '<cmd>GoDbgContinue<cr>')
map('n', '<leader>dr', '<cmd>GoDebug -R<cr>')
map('n', '<leader>ds', '<cmd>GoDebug -s<cr>')
map('n', '<leader>db', '<cmd>GoBreakToggle<cr>')

-- Make `d' to just delete without cutting
map('n', 'd', '"_d')
map('v', 'd', '"_d')
