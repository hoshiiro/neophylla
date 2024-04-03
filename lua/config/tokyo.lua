local tokyo = require('tokyonight')

local opts = {
	style = 'moon',
	styles = {
		comments = { italic = false },
	},
	on_highlights = function(hl, c)
		hl.TelescopeBorder = {
			bg = c.bg_float,
			fg = c.bg_float,
		}
		hl.TelescopePromptBorder = {
			bg = c.bg_float,
			fg = c.bg_float,
		}
		hl.TelescopeResultsTitle = {
			bg = c.fg_gutter,
			fg = c.teal,
		}

		hl.TelescopePromptTitle = {
			bg = c.teal,
			fg = c.bg_dark,
		}
		hl.TelescopePromptPrefix = {
			fg = c.teal,
		}
		hl.TelescopeSelection = {
			-- bg = '#135348'
			bg = c.fg_gutter,
		}
		hl.FloatTitle = {
			fg = c.teal,
		}
		hl.FloatBorder = {
			fg = c.teal,
			bg = c.bg_dark,
		}
		hl.Cmdline = {
			bg = c.bg_float,
			fg = c.fg,
		}
		hl.TelescopeMatching = {
			fg = c.teal,
		}
		hl.lualine_buffers_active = {
			bg = c.teal,
			fg = c.bg_dark,
		}
		hl.lualine_buffers_inactive = {
			bg = c.fg_gutter,
			fg = c.teal,
		}
		hl.CursorLineNr = {
			fg = c.teal,
		}
		hl.CursorLine = {
			bg = c.bg,
		}
	end,
}

tokyo.setup(opts)
tokyo.load()
