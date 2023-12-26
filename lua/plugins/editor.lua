return {
	{
		'stevearc/dressing.nvim',
		event = 'VeryLazy',
		opts = {},
	},
	{
		'nvim-lualine/lualine.nvim',
		event = { 'BufNewFile', 'BufReadPost' },
		config = function()
			require('configs.lualine')
		end,
	},
	{
		'akinsho/bufferline.nvim',
		event = { 'BufNewFile', 'BufReadPost' },
		config = function()
			require('bufferline').setup({
				options = {
					diagnostics = 'nvim_lsp',
					diagnostics_indicator = function(count, level)
						local icon = level:match('error') and ' ' or ' '
						return ' ' .. icon .. count
					end,
				},
			})
		end,
	},
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		dependencies = {
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
			},
		},
		branch = '0.1.x',
		config = function()
			require('configs.telescope')
		end,
	},
	{
		'natecraddock/workspaces.nvim',
		cmd = { 'Workspaces' },
		config = function()
			require('workspaces').setup({
				hooks = {
					open = { 'Telescope find_files' },
				},
			})
		end,
	},
}
