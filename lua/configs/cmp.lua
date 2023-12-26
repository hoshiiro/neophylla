-- luasnip setup
local luasnip = require('luasnip')
require('luasnip.loaders.from_snipmate').lazy_load()

-- cmp setup
local cmp = require('cmp')
local lspkind = require('lspkind')
local cctx = require('cmp.config.context')

vim.api.nvim_set_hl(0, 'CmpChostText', { link = 'Comment', default = true })

cmp.setup({
	enabled = function()
		if
			cctx.in_treesitter_capture('comment') == true
			or cctx.in_syntax_group('Comment')
		then
			return false
		else
			return true
		end
	end,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text',
			menu = {
				buffer = '[Buffer]',
				nvim_lsp = '[LSP]',
				luasnip = '[LuaSnip]',
				nvim_lua = '[Lua]',
				latex_symbols = '[Latex]',
				cmp_path = '[Path]',
			},
		}),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
		['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
		-- C-b (back) C-f (forward) for snippet placeholder navigation.
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
		{ name = 'path' },
	}, { name = 'buffer' }),
	experimental = {
		ghost_text = {
			hl_group = 'CmpGhostText',
		},
	},
})
