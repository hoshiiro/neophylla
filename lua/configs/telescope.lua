require('telescope').setup({
	defaults = {
		color_devicons = false,
		prompt_prefix = '   ',
		selection_caret = ' ',
		entry_prefix = ' ',
		layout_strategy = 'horizontal',
		layout_config = { width = 0.92, height = 0.60 },
	},
})

if pcall(require('scope')) then
	require('telescope').load_extension('scope')
end

require('telescope').load_extension('fzf')
require('telescope').load_extension('workspaces')
