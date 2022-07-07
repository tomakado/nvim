local M = {}
local api = vim.api

function M.map(mode, lhs, rhs, input_opts)
	local opts = { noremap = true }
	if input_opts then
		opts = vim.tbl_extend('force', opts, input_opts)
	end

	api.nvim_set_keymap(mode, lhs, rhs, opts)
end

return M
