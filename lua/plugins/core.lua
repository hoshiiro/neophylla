return {
	{ 'nvim-lua/plenary.nvim', lazy = true },
	{ 'nvim-tree/nvim-web-devicons', lazy = true },

	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			require('configs.lspconfig')
		end,
	},
	{
		'folke/tokyonight.nvim',
		priority = 1000,
		config = function()
			require('configs.tokyonight')
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		event = { 'BufRead', 'BufNewFile' },
		init = function(plugin)
			require('lazy.core.loader').add_to_rtp(plugin)
			require('nvim-treesitter.query_predicates')
		end,
		dependencies = {
			'windwp/nvim-ts-autotag',
		},
		build = ':TSUpdate',
		config = function()
			require('configs.treesitter')
		end,
	},
	{
		'hrsh7th/nvim-cmp',
		event = { 'InsertEnter' },
		dependencies = {
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lsp',

			'neovim/nvim-lspconfig',
			'onsails/lspkind.nvim',

			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip',
		},
		config = function()
			require('configs.cmp')
		end,
	},
}
