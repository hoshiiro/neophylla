local opts = { silent = true, noremap = true }
local vks = function(...)
	local args = { ... }
	vim.keymap.set(args[1], args[2], args[3], opts)
end

vks('n', '<leader><leader>', ':Telescope find_files<cr>')
vks('n', '<leader>g', ':Neogit<cr>')
vks('n', '<leader>w', ':Telescope workspaces<cr>')
vks('n', '<leader>d', function()
	require('oil').open_float()
end)
vks('n', '<leader>b', function()
	require('buffer_manager.ui').toggle_quick_menu()
end)

vks('n', '<C-b>', ':bprev<cr>')
vks('n', '<C-n>', ':bnext<cr>')

vks('v', 'k', ":m '<-2<cr>gv=gv")
vks('v', 'j', ":m '>+1<cr>gv=gv")

vks('n', ',p', ':Lazy profile<cr>')
vks('n', ',hs', function()
	require('gitsigns').stage_hunk()
end)
vks('n', ',hu', function()
	require('gitsigns').undo_stage_hunk()
end)
vks('n', ',hr', function()
	require('gitsigns').reset_hunk()
end)
vks('n', ',hp', function()
	require('gitsigns').preview_hunk()
end)
