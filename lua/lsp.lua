local luasnip = require('luasnip')
local cmp = require('cmp')

local api = vim.api
local fn = vim.fn
local lsp = vim.lsp
local o = vim.o

local servers = { 'gopls', 'pyright', 'lua_ls', 'rust_analyzer', 'gdscript', 'clojure_lsp' }

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

	-- Mappings.
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set('n', 'lgD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'lgd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'lK', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'lgi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<space>lwa', vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set('n', '<space>lwr', vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set('n', '<space>lwl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set('n', '<space>lD', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'lgr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<space>le', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
	vim.keymap.set('n', '<space>lf', function()
		vim.lsp.buf.format({ async = false })
	end, opts)
end

-- Run gofmt + goimports on save
local format_sync_grp = api.nvim_create_augroup("goimports", {})
api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require('go.format').goimports()
	end,
	group = format_sync_grp,
})

-- Set completeopt to have a better completion experience
o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
cmp.setup {
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<S-Tab>'] = function(fallback)
			if fn.pumvisible() == 1 then
				fn.feedkeys(api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
			elseif luasnip.jumpable(-1) then
				fn.feedkeys(api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
	},
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure common settings for all servers
vim.lsp.config['*'] = {
	on_attach = on_attach,
	capabilities = capabilities,
}

-- Configure individual servers
vim.lsp.config.gopls = {
	cmd = { 'gopls' },
	filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
	root_markers = { 'go.work', 'go.mod', '.git' },
}

vim.lsp.config.pyright = {
	cmd = { 'pyright-langserver', '--stdio' },
	filetypes = { 'python' },
	root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				extraPaths = {
					'./src',
					'$VIRTUAL_ENV/lib/python3.8/site-packages',
				},
			},
		},
	},
}

vim.lsp.config.lua_ls = {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' } },
			workspace = { 
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
}

vim.lsp.config.rust_analyzer = {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	root_markers = { 'Cargo.toml', 'rust-project.json' },
}

vim.lsp.config.gdscript = {
	cmd = { 'nc', 'localhost', '6005' },
	filetypes = { 'gd', 'gdscript', 'gdscript3' },
	root_markers = { 'project.godot', '.git' },
}

vim.lsp.config.clojure_lsp = {
	cmd = { 'clojure-lsp' },
	filetypes = { 'clojure', 'edn' },
	root_markers = { 'project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn', '.git' },
}

-- Enable all servers
for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end
