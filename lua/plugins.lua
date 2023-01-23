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
					-- component_separators = { left = '', right = '' },
					-- section_separators = { left = '', right = '' },
				}
			})
		end,
	}

	-- Fancy diagnostics UI
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

	-- Commenting code
	use 'tpope/vim-commentary'

	-- -- Indent lines
	-- use {
	-- 	'lukas-reineke/indent-blankline.nvim',
	-- 	config = function()
	-- 		require('indent_blankline').setup {
	-- 			-- for example, context is off by default, use this to turn it on
	-- 			show_current_context = true,
	-- 			show_current_context_start = true,
	-- 		}
	-- 	end,
	-- }

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

	use 'mbbill/undotree'

	use {
		'folke/todo-comments.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('todo-comments').setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	}

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
	use { 'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			require('rose-pine').setup {
				disable_italics = true,
				background = 'moon',
			}
		end,
	}
	use 'mrjones2014/lighthaus.nvim'
	use {
		"mcchrish/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		requires = "rktjmp/lush.nvim"
	}

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

	-- EdgeDB
	use 'edgedb/edgedb-vim'

	-- D2
	use 'terrastruct/d2-vim'

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

	-- Godot support
	use 'habamax/vim-godot'

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
