require('plugins')
require('user.mappings')
require('lsp')
require('markdown')
--local dap = require('dap')

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local o = vim.o
local opt = vim.opt
local api = vim.api
local cmd = vim.cmd

opt.number = true
opt.cursorline = true
opt.smartindent = true
opt.ignorecase = true
opt.encoding = 'utf-8'
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
opt.relativenumber = true

cmd [[set nofoldenable]]
cmd [[set noswapfile]]
cmd [[set clipboard+=unnamedplus]]

--g.tokyonight_style = 'day'
g.spacegray_low_contrast = 1
g.material_style = 'darker'

g.blamer_enabled = 1

cmd.colorscheme('catppuccin')

cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

g.copilot_enabled = true

-- Folding
opt.foldmethod = 'manual'

opt.linebreak = true
