require('plugins')
require('user.mappings')
require('lsp')
--local dap = require('dap')

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local o = vim.o
local opt = vim.opt
local api = vim.api

opt.number = true
opt.cursorline = true
opt.smartindent = true
opt.ignorecase = true
opt.encoding = "utf-8"
opt.termguicolors = true
opt.splitright = true
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.mouse = 'a'
opt.foldmethod = 'indent'
opt.ruler = true
opt.colorcolumn = '120'
opt.background = 'dark'
opt.numberwidth = 5

cmd [[set nofoldenable]]
cmd [[set noswapfile]]

g.tokyonight_style = 'night'
g.spacegray_low_contrast = 1
g.material_style = 'darker'

cmd [[colorscheme vscode]]

cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- Setup Go for DAP
-- FIXME
-- dap.adapters.go = {
-- 	type = 'executable';
-- 	command = 'node';
-- 	args = { os.getenv('HOME') .. '/opt/vscode-go/dist/debugAdapter.js' };
-- }

-- dap.configurations.go = {
-- 	{
-- 		type = 'go';
-- 		name = 'Debug';
-- 		request = 'launch';
-- 		showLog = true;
-- 		program = '${workspaceFolder}/cmd/backend/main.go';
-- 		dlvToolPath = fn.exepath('dlv') -- Adjust to where delve is installed
-- 	},
-- }

g.copilot_enabled = true

-- Folding
opt.foldmethod = 'manual'

-- Line wrapping for Markdown
api.nvim_create_autocmd('BufEnter', {
	pattern = { '*.md' },
	group = group,
	command = 'setlocal wrap'
})

opt.linebreak = true
