-- This is a script to replace netrw with oil.nvim.
-- It works by detecting a netrw buffer, wipe it and call
-- oil.nvim instead.

-- Usage: require it like any other lua file

-- The code is taken from the source code of telescope-file-browser.nvim
-- Copyright (c) 2021 nvim-telescope authors
-- modified slightly my me.

local netrw_bufname

pcall(vim.api.nvim_clear_autocmds, { group = 'FileExplorer' })
vim.api.nvim_create_autocmd('VimEnter', {
	pattern = '*',
	once = true,
	callback = function()
		pcall(vim.api.nvim_clear_autocmds, { group = 'FileExplorer' })
	end,
})

vim.api.nvim_create_autocmd('BufEnter', {
	group = vim.api.nvim_create_augroup('oil.nvim', { clear = true }),
	pattern = '*',
	callback = function()
		vim.schedule(function()
			if vim.bo[0].filetype == 'netrw' then
				return
			end
			local bufname = vim.api.nvim_buf_get_name(0)
			if vim.fn.isdirectory(bufname) == 0 then
				_, netrw_bufname = pcall(vim.fn.expand, '#:p:h')
				return
			end

			if netrw_bufname == bufname then
				netrw_bufname = nil
				return
			else
				netrw_bufname = bufname
			end

			vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')
			require('oil').setup({})
		end)
	end,
})
