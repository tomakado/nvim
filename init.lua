require('plugins')
require('user.mappings')
require('lsp')
local dap = require('dap')

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

cmd [[set nofoldenable]]
cmd [[set noswapfile]]

g.tokyonight_style = 'night'

cmd [[set background=dark]]
cmd [[colorscheme gruvbox]]

cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- Setup Go for DAP
-- FIXME
dap.adapters.go = {
	type = 'executable';
	command = 'node';
	args = { os.getenv('HOME') .. '/opt/vscode-go/dist/debugAdapter.js' };
}

dap.configurations.go = {
	{
		type = 'go';
		name = 'Debug';
		request = 'launch';
		showLog = true;
		program = '${workspaceFolder}/cmd/backend/main.go';
		dlvToolPath = fn.exepath('dlv') -- Adjust to where delve is installed
	},
}

g.copilot_enabled = true