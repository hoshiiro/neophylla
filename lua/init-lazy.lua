local lazy_spec = {
	{ 'nvim-lua/plenary.nvim' },
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'j-morano/buffer_manager.nvim' },
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('config.tokyo')
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		event = { 'BufRead', 'BufNewFile' },
		dependencies = {
			'windwp/nvim-ts-autotag',
		},
		config = function()
			require('nvim-treesitter.configs').setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				autotag = { enable = true },
			})
		end,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{
				'simrat39/inlay-hints.nvim',
				opts = {
					renderer = 'inlay-hints/render/eol',
				},
			},
		},
		event = { 'BufRead', 'BufNewFile' },
		config = function()
			require('config.lspconfig')
		end,
	},
	{
		'hrsh7th/nvim-cmp',
		event = { 'InsertEnter' },
		dependencies = {
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lsp',

			'onsails/lspkind.nvim',

			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			require('config.cmp')
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
			{
				'natecraddock/workspaces.nvim',
				opts = { hooks = { open = 'Telescope find_files' } },
			},
		},
		branch = '0.1.x',
		config = function()
			local tscope = require('telescope')

			tscope.setup({
				defaults = {
					color_devicons = false,
					prompt_prefix = '   ',
					selection_caret = ' ',
					entry_prefix = ' ',
					layout_config = { width = 0.92, height = 0.60 },
				},
			})

			tscope.load_extension('fzf')
			tscope.load_extension('workspaces')
		end,
	},
	{
		'b0o/incline.nvim',
		event = { 'BufRead', 'BufNewFile' },
		config = function()
			require('config.incline')
		end,
	},
	{
		'stevearc/conform.nvim',
		event = { 'BufRead', 'BufNewFile' },
		opts = {
			format_on_save = {
				timeout_ms = 300,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { 'stylua' },
				python = { 'ruff' },
				go = { 'gofmt' },
				rust = { 'rustfmt' },
				typescript = { 'eslint' },
				svelte = { 'eslint' },
			},
		},
	},
	{
		'echasnovski/mini.indentscope',
		event = { 'BufRead', 'BufNewFile' },
		version = false,
		opts = {},
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = { check_ts = true, map_cr = true },
	},
	{
		'echasnovski/mini.comment',
		event = { 'BufReadPost', 'BufNewFile' },
		version = false,
		opts = {},
	},
	{
		'stevearc/oil.nvim',
		opts = {
			columns = {},
			float = {
				padding = 2,
				max_width = 92,
				max_height = 20,
			},
		},
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
	{
		'wakatime/vim-wakatime',
		event = { 'BufRead', 'BufNewFile' },
	},
	{
		'kylechui/nvim-surround',
		event = { 'BufRead', 'BufNewFile' },
		opts = {},
	},
	{
		'preservim/vim-pencil',
		ft = { 'markdown', 'text', 'gemtext' },
		config = function()
			vim.o.conceallevel = 2
			vim.g['pencil#wrapModeDefault'] = 'soft'
			vim.cmd([[call pencil#init()]])
		end,
	},
	{
		'epwalsh/obsidian.nvim',
		version = '*',
		ft = { 'markdown' },
		dependencies = {
			'preservim/vim-pencil',
		},
		config = function()
			vim.o.conceallevel = 2
			require('config.obsidian')
		end,
	},
}

local lazy_opts = {
	defaults = {
		lazy = true,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				'gzip',
				'rplugin',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
				'shada',
				'spellfile',
			},
		},
	},
}

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup(lazy_spec, lazy_opts)
