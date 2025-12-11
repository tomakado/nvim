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

return require('packer').startup({
	function()
		-- Packer can manage itself
		use 'wbthomason/packer.nvim'

		use 'nvim-lua/popup.nvim'
		use 'nvim-lua/plenary.nvim'
		use 'kyazdani42/nvim-web-devicons'

		-- ==> Load nvim-telesecope.
		use { 'nvim-telescope/telescope.nvim',
			requires = { 'nvim-lua/plenary.nvim' },
			config = function()
				require('telescope').setup({
					extensions = {
						dash = {
							dash_app_path = '/Applications/Setapp/Dash.app',
							debounce = 150,
						}
					}
				})
			end
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
					ensure_installed = { 'go', 'python', 'lua', 'vim', 'rust', 'yaml', 'toml', 'typescript', 'javascript', 'vimdoc' }
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

		-- ==> Load lualine
		use { 'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true },
			config = function()
				require('lualine').setup({
					options = {
						theme = "auto",
						-- component_separators = { left = '', right = '' },
						-- section_separators = { left = '', right = '' },
					},
					sections = {
						lualine_x = {
							-- Options with default values
							{
								"copilot",
								show_running = true,
								symbols = {
									status = {
										enabled = " ",
										disabled = " ",
									},
									spinners = require("copilot-status.spinners").dots,
								},
							},
						}
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
		use 'ofseed/copilot-status.nvim'

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

		-- Highlight color HEX codes
		use {
			'norcalli/nvim-colorizer.lua',
			config = function()
				require('colorizer').setup()
			end,
		}

		-- Color schemes
		use {
			"catppuccin/nvim", as = "catppuccin",
			config = function()
				require('catppuccin').setup({
					flavour = "mocha",
					-- transparent_background = true,
					-- float = {
					-- 	transparent = true,
					-- },
				})
				vim.cmd.colorscheme('catppuccin')
			end,
		}
		use 'folke/tokyonight.nvim'
		use "savq/melange"
		use "ellisonleao/gruvbox.nvim"
		use 'bluz71/vim-moonfly-colors'
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
		use { 'nvim-tree/nvim-tree.lua',
			config = function()
				require('nvim-tree').setup()
			end,
		}


		-- Debug
		-- use 'puremourning/vimspector'
		use {
			'mfussenegger/nvim-dap',
			config = function()
				local dap, dapui = require("dap"), require("dapui")

				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end

				dap.listeners.before.launch.dapui_config = function()
					dapui.open()
				end

				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end

				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end
			end
		}
		use 'theHamsta/nvim-dap-virtual-text'
		use {
			'leoluz/nvim-dap-go',
			requires = {
				'mfussenegger/nvim-dap'
			},
			config = function()
				require('dap-go').setup()
			end,
		}
		use {
			'rcarriga/nvim-dap-ui',
			requires = {
				'nvim-neotest/nvim-nio',
				'mfussenegger/nvim-dap'
			},
			config = function()
				require('dapui').setup()
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

		-- Lua support
		use 'folke/neodev.nvim'

		-- Godot support
		use 'habamax/vim-godot'

		-- Emmet support
		use 'mattn/emmet-vim'

		-- Clojure support
		use 'Olical/conjure'
		use 'guns/vim-sexp'

		-- Dash and doc search
		use({
			'mrjones2014/dash.nvim',
			run = 'make install',
		})

		use 'nvimtools/none-ls.nvim'

		-- Easy align
		use 'junegunn/vim-easy-align'

		-- Automatically setup plugins on first launch
		if packer_bootstrap then
			require('packer').sync()
		end
	end,
	config = {
		display = {
			open_fn = require('packer.util').float,
		}
	}
})
