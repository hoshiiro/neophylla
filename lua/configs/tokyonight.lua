require('tokyonight').setup({
	style = 'moon',
	styles = {
		keywords = { italic = false },
		comments = { italic = false },
	},
	on_highlights = function(hl, c)
		hl.TelescopeNormal = {
			bg = c.bg_float,
			fg = c.fg_float,
		}
		hl.TelescopeBorder = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopeResultsTitle = {
			bg = c.green,
			fg = c.bg_dark,
		}
		hl.TelescopePromptTitle = {
			bg = c.blue,
			fg = c.bg_dark,
		}
		hl.TelescopeSelection = {
			bg = c.bg_highlight,
			fg = c.fg_float,
		}
		hl.BufferLineFill = {
			bg = c.bg_dark,
		}
		hl.BufferLineTabSelected = {
			bg = c.bg_dark,
			fg = c.blue,
		}
		hl.Folded = {
			fg = c.blue,
			bg = c.bg_float,
		}
		hl.BufferLineErrorDiagnostic = {
			bg = c.bg_dark,
			fg = c.red,
		}
	end,
})
