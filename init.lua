require('plugins')
require('user.mappings')
require('lsp')
require('markdown')
require('copilot')
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
opt.tabstop = 4
opt.shiftwidth = 4
opt.mouse = 'a'
opt.ruler = true
opt.colorcolumn = '120'
opt.background = 'dark'
opt.numberwidth = 5
opt.relativenumber = true
opt.signcolumn = "yes:1"

cmd [[set noswapfile]]
cmd [[set clipboard+=unnamedplus]]

g.spacegray_low_contrast = 1

g.blamer_enabled = 1

cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

g.copilot_enabled = true

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
cmd [[ set nofoldenable]] 
api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx", })

opt.linebreak = true

opt.spell = true
opt.spelllang = 'en_us,en_gb,es_es,es_mx,ru_ru'
