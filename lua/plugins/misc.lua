return {
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = { check_ts = true, map_cr = true },
	},
	{
		'echasnovski/mini.comment',
		event = { 'BufRead', 'BufNewFile' },
		keys = { 'gc' },
		version = false,
		opts = {},
	},
	{
		'echasnovski/mini.indentscope',
		event = { 'BufRead' },
		version = false,
		opts = {},
	},
	{
		'preservim/vim-pencil',
		cmd = { 'Pencil' },
		config = function()
			vim.g['pencil#wrapModeDefault'] = 'soft'
		end,
	},
	{ 'stevearc/oil.nvim', event = { 'BufRead' }, opts = {} },
	{
		'mickael-menu/zk-nvim',
		cmd = { 'ZkNew', 'ZkNotes' },
		config = function()
			require('zk').setup({
				picker = 'telescope',
			})
		end,
	},
	{
		'NeogitOrg/neogit',
		cmd = { 'Neogit' },
		opts = {
			commit_view = {
				kind = 'tab',
			},
		},
	},
	{ 'tiagovla/scope.nvim', event = { 'TabNew' }, config = true },
}
