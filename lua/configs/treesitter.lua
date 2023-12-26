local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.gotmpl = {
	install_info = {
		url = 'https://github.com/ngalaiko/tree-sitter-go-template',
		files = { 'src/parser.c' },
	},
	filetype = 'gotmpl',
	used_by = { 'gohtmltmpl', 'gotexttmpl', 'gotmpl' },
}

require('nvim-treesitter.configs').setup({
	ensure_installed = { 'org' },
	auto_install = true,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = { 'org' },
	},
	indent = { enable = true },
	autotag = { enable = true },
})
