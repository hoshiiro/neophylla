local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

configs.zk = {
	default_config = {
		cmd = { 'zk', 'lsp' },
		filetypes = { 'markdown' },
		root_dir = function()
			return vim.loop.cwd()
		end,
		settings = {},
	},
}

local servers = { 'gopls', 'clangd', 'pyright', 'tsserver', 'zk' }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	})
end

--Enable (broadcasting) snippet capability for completion
local addcpb = vim.lsp.protocol.make_client_capabilities()
addcpb.textDocument.completion.completionItem.snippetSupport = true

-- lsp-server that need additional capabilities
local aservers = { 'html', 'cssls', 'jsonls' }
for _, lsp in ipairs(aservers) do
	lspconfig[lsp].setup({
		capabilities = addcpb,
	})
end

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if
			not vim.loop.fs_stat(path .. '/.luarc.json')
			and not vim.loop.fs_stat(path .. '/.luarc.jsonc')
		then
			client.config.settings =
				vim.tbl_deep_extend('force', client.config.settings, {
					Lua = {
						runtime = {
							version = 'LuaJIT',
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							},
						},
					},
				})

			client.notify(
				'workspace/didChangeConfiguration',
				{ settings = client.config.settings }
			)
		end
		return true
	end,
})

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>k', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<space>j', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
