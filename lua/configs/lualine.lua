local function lsp_client()
	local msg = 'No Active Lsp'
	local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
	return msg
end

require('lualine').setup({
	options = {
		icons_enabled = true,
		-- component_separators = {},
		ssction_comparators = {},
	},
	sections = {
		lualine_a = {
			{
				'mode',
				fmt = function(str)
					return str:sub(1, 1)
				end,
			},
		},
		lualine_b = { 'branch' },
		lualine_c = {
			{
				'filename',
				symbols = {
					modified = '[~]',
					readonly = '[-]',
					unnamed = '[?]',
					newfile = '[+]',
				},
			},
			{
				'filetype',
				colored = false,
			},
		},
		lualine_x = {
			{
				'diff',
				diff_color = {
					added = 'diffAdded',
					modified = 'diffChanged',
					removed = 'diffRemoved',
				},
			},
			'diagnostics',
			{ lsp_client, icon = ' ' },
		},
		lualine_y = {},
		lualine_z = {},
	},
})
