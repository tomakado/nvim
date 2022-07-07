local cmd = vim.cmd

local M = {}

--cmd [[nnoremap <leader> <cmd>WhichKey<cr>]]
--cmd [[vnoremap <leader> <cmd>WhichKey '' v<cr>]]
--cmd [[inoremap <M-k> <cmd>WhichKey <leader> i<cr>]]
--cmd [[cnoremap <M-k> <cmd>WhichKey <leader> c<cr>]]

function M.setup()
	local which_key = require('which-key')

	local config = {
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			presets = {
				operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		key_labels = {
			-- override the label used to display some keys. It doesn't effect WK in any other way.
			-- For example:
			["<c>"] = "CTRL",
			["<space>"] = "SPC",
			["<cr>"] = "RET",
			["<tab>"] = "TAB",
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "rounded", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "center", -- align columns left, center or right
		},
		ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		--triggers = "auto", -- automatically setup triggers
		--triggers = {"<leader>"}, -- or specify a list manually
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			--n = { "f", "g", "p", "l" },
			i = { "j", "k" },
			v = { "j", "k" },
		},
	}

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = false, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local mappings = {
		p = {
			name = "Packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
		},
		['g'] = {
			name = 'Git',
			g = { '<cmd>LazyGit<cr>', 'Show LazyGit window' },
		},
		f = {
			name = 'Files',
			f = { '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍 <cr>', 'Find files' },
			e = { '<cmd>Neotree toggle<cr>', 'Toggle file explorer' },
		},
		l = {
			name = 'LSP',
			g = {
				name = 'Go to',
				D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Declaration' },
				d = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Defintion' },
				i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Implementation' },
				r = { '<cmd>lua vim.lsp.buf.references()<cr>', 'References' },
			},
			d = {
				name = 'Diagnostics',
				l = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', 'Show line diagnostics' },
				p = { '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', 'Go to previous' },
				n = { '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', 'Go to next' },
			},
			K = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Hover' },
			['<C-k>'] = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature help' },
			r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
			a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action' },
			f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format' },
		},
		["h"] = { "<cmd>nohlsearch<CR>", "No HL" },
		s = {
			name = 'Search',
			s = { '<cmd>Telescope live_grep }prompt_prefix=🔍 <cr>', 'Search in files (live grep)' },
			f = { '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍 <cr>', 'Find files' },
		},
	}

	which_key.setup(config)
	which_key.register(mappings, opts)
end

return M
