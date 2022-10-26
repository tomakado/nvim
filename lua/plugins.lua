-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		'git',
		'clone',
		'--depth', '1',
		'https://github.com/wbthomason/packer.nvim',
		install_path
	})
end

return require('packer').startup({ function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'kyazdani42/nvim-web-devicons'

	-- ==> Load nvim-telesecope.
	use { 'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } },
	}

	use {
		'kylechui/nvim-surround',
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require('nvim-surround').setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	}

	-- ==> Load treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup {
				highlight = {
					enable = true,
				},
				additional_vim_regex_highlighting = false,
			}

			local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
			parser_config.just = {
				install_info = {
					url = 'https://github.com/IndianBoy42/tree-sitter-just', -- local path or git repo
					files = { 'src/parser.c', 'src/scanner.cc' },
					branch = 'main',
				},
				maintainers = { '@IndianBoy42' },
			}
		end
	}

	-- ==> Load pretty-fold
	use { 'anuvyklack/pretty-fold.nvim',
		config = function()
			require('pretty-fold').setup()
		end
	}

	-- ==> Load lualine
	use { 'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('lualine').setup({
				options = {
					theme = "auto",
					component_separators = { left = '', right = '' },
					section_separators = { left = '', right = '' },
				}
			})
		end,
	}

	-- Commenting code
	use 'tpope/vim-commentary'

	-- Code analysis and completion
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	use 'github/copilot.vim'

	-- Color schemes
	use 'folke/tokyonight.nvim'
	use "savq/melange"
	use "ellisonleao/gruvbox.nvim"
	use 'bluz71/vim-moonfly-colors'
	use 'ackyshake/Spacegray.vim'
	use 'doums/darcula'
	use 'marko-cerovac/material.nvim'
	use { 'shaunsingh/oxocarbon.nvim', run = './install.sh' }
	use { "ntk148v/komau.vim" }
	use 'Mofiqul/vscode.nvim'
	use 'rebelot/kanagawa.nvim'
	use 'rockerBOO/boo-colorscheme-nvim'

	-- Git
	use 'airblade/vim-gitgutter'
	use 'kdheepak/lazygit.nvim'
	use 'APZelos/blamer.nvim'

	-- File explorer
	use { 'nvim-neo-tree/neo-tree.nvim',
		branch = 'v2.x',
		requires = {
			'nvim-lua/plenary.nvim',
			'kyazdani42/nvim-web-devicons', -- optional, for file icons
			'MunifTanjim/nui.nvim',
		},
		config = function()
			require('neo-tree').setup({
				window = {
					mappings = {
						['<c-cr>'] = { 'toggle_node', nowait = true },
						['<space>'] = 'none',
					},
				},
			})
		end,
	}

	-- Advanced Go language support
	use {
		'ray-x/go.nvim',
		config = function()
			require('go').setup()
		end,
	}
	use 'ray-x/guihua.lua'
	-- use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
	-- use {
	-- 	'yriveiro/dap-go.nvim',
	-- 	requires = { 'nvim-lua/plenary.nvim' },
	-- 	config = function()
	-- 		local git_ancestor = require('lspconfig.util').find_git_ancestor(vim.loop.fs_realpath('.'))
	-- 		if git_ancestor == nil then
	-- 			return
	-- 		end

	-- 		require('dap-go').setup({
	-- 			external_config = {
	-- 				enable = true,
	-- 				path = git_ancestor .. '/.vscode/launch.json'
	-- 			}
	-- 		})
	-- 	end
	-- }

	-- Automatically setup plugins on first launch
	if packer_bootstrap then
		require('packer').sync()
	end
end,
	config = {
		display = {
			open_fn = require('packer.util').float,
		}
	} })
