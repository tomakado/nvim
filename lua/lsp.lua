local lspconfig = require('lspconfig')
local luasnip = require('luasnip')
local cmp = require('cmp')

local api = vim.api
local fn = vim.fn
local lsp = vim.lsp
local o = vim.o

local servers = {'gopls', 'pyright', 'sumneko_lua', 'rust_analyzer'}

local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'lgd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'lK', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'lgi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>lD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'lgr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>le', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- local server_config = function(server_name, cfg)
-- 	local maybe_config = function(server_name_to_test)
-- 		return server_name_to_test == server_name and cfg or {}
-- 	end
-- end

local get_project_root = function(server_name)
	local root_fn =  function()
		if server_name == 'pyright' or server_name == 'pyls' then
			return fn.getcwd() .. '/src'
		else
			return fn.getcwd()
		end
	end

	return root_fn
end

-- Set completeopt to have a better completion experience
o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
cmp.setup {
  -- completion = {
	-- 	autocomplete = false
  -- },
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
    --['<Tab>'] = function(fallback)
    --  if fn.pumvisible() == 1 then
    --    fn.feedkeys(api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
    --  elseif luasnip.expand_or_jumpable() then
    --    fn.feedkeys(api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
    --  else
    --   fallback()
    --  end
    --end,
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

local capabilities = require('cmp_nvim_lsp').update_capabilities(lsp.protocol.make_client_capabilities())

for _, server in ipairs(servers) do
	lspconfig[server].setup {
		on_attach = on_attach,
		capabilities = capabilities,
		-- root_dir = get_project_root(server),
		flags = {
			debounce_text_changes = 150,
		},
		settings = {
			pyright = {
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
end

