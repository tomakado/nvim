local g = vim.g
local cmd = vim.cmd
local map = require('utils').map
map('n', '<space>', '<nop')
g.mapleader = '<Space>'
g.maplocalleader = ','
cmd [[map <space> <leader>]]

-- Telescope
map('n', '<leader>sf', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>')
map('n', '<leader>s', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>sb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>sr', '<cmd>Telescope oldfiles<cr>')
map('n', '<leader>slr', '<cmd>Telescope lsp_references<cr>')
map('n', '<leader>sli', '<cmd>Telescope lsp_implementations<cr>')
map('n', '<leader>sld', '<cmd>Telescope diagnostics bufnr=0<cr>')
map('n', '<leader>sc', '<cmd>Telescope commands<cr>')
map('n', '<leader>st', '<cmd>TodoTelescope<cr>')

-- Trouble
map('n', '<leader>tld', '<cmd>Trouble diagnostics<cr>')
map('n', '<leader>tqf', '<cmd>Trouble quickfix<cr>')

-- Neotree
-- map('n', '<leader>fe', '<cmd>Neotree toggle<cr>')

-- nvim-tree
map('n', '<leader>fe', '<cmd>NvimTreeToggle<cr>')

-- Debugger
map('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<cr>')
map('n', '<leader>d', '<cmd>lua require("dap").continue()<cr>')
map('n', '<leader>dr', '<cmd>lua require("dap").restart()<cr>')
map('n', '<leader>dt', '<cmd>lua require("dap").terminate()<cr>')
map('n', '<leader>dso', '<cmd>lua require("dap").step_over()<cr>')
map('n', '<leader>dsi', '<cmd>lua require("dap").step_into()<cr>')
map('n', '<leader>dsb', '<cmd>lua require("dap").step_back()<cr>')
map('n', '<leader>?', '<cmd>lua require("dapui").eval(nil, { enter = true })<cr>')

-- Make `d' to just delete without cutting
map('n', 'd', '"_d')
map('v', 'd', '"_d')

-- Toggle undo tree
map('n', '<leader>u', '<cmd>UndotreeToggle<cr>')

-- LazyGit
map('n', '<leader>gg', '<cmd>LazyGit<cr>')
