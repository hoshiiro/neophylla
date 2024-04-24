require('obsidian').setup({
	workspaces = {
		{
			name = 'main',
			path = '~/notes',
		},
	},
	completion = {
		nvin_cmp = true,
		min_chars = 3,
	},
	---@return string
	note_id_func = function()
		return tostring(os.date('%Y%m%d%H%M'))
	end,
	note_path_func = function(spec)
		-- local dt = tostring(os.date('%Y-%m-%d'))
		local fn =
			tostring(spec.title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower())
		local path = spec.dir / fn
		return path:with_suffix('.md')
	end,
	wiki_link_func = 'prepend_note_path',
	preferred_link_style = 'markdown',
	note_frontmatter_func = function(note)
		local out = {
			id = note.id,
			aliases = note.aliases,
			tags = note.tags,
		}
		if note.title then
			note:add_alias(note.title)
			out['title'] = note.title
		end
		if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
			for k, v in pairs(note.metadata) do
				out[k] = v
			end
		end
		return out
	end,
})
