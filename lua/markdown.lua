local api = vim.api

-- Line wrapping 
api.nvim_create_autocmd('BufEnter', {
	pattern = { '*.md' },
	group = group,
	command = 'setlocal wrap'
})

-- Spellchecking
api.nvim_create_autocmd('BufRead,BufNewFile', {
	pattern = { '*.md' },
	group = group,
	command = 'setlocal spell spelllang=ru_ru,en_gb,en_us'
})
