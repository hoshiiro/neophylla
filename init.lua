vim.loader.enable()

-- Global options

local g = vim.g

g.mapleader = ' '
g.maplocalleader = ','

g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- g.markdown_folding = 1
-- g.foldstartlevel = 99

-- Options

local o = vim.opt

o.shortmess = 'filnxtToOFI'
o.conceallevel = 3
o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true
o.number = true
--o.relativenumber = false
o.smartindent = true
o.timeoutlen = 500

o.signcolumn = 'no'

local vks = vim.keymap.set
local opts = { silent = true }

vks('n', '-', '<C-A>', opts)
vks('n', '+', '<C-X>', opts)
vks('n', '<C-Left>', ':bprev<CR>', opts)
vks('n', '<A-Left>', ':tabp<CR>', opts)
vks('n', '<C-Right>', ':bnext<CR>', opts)
vks('n', '<A-Right>', ':tabn<CR>', opts)

vks('n', '<leader><leader>', ':Telescope find_files<CR>', opts)
vks('n', '<leader>fh', ':Telescope find_files hidden=true<CR>', opts)
vks('n', '<leader>ft', ':Telescope help_tags<CR>', opts)
vks('n', '<leader>fb', ':Telescope scope buffers<CR>', opts)
vks('n', '<leader>fg', ':Telescope live_grep<CR>', opts)
vks('n', '<leader>ww', ':Telescope workspaces<CR>', opts)
vks('n', '<leader>gg', ':Neogit<cr>', opts)

vks('n', '<localleader>p', ':vi"<cr>', opts)
vks('n', '<localleader>zn', ':ZkNew<cr>', opts)
vks('n', '<localleader>zl', ':ZkNotes<cr>', opts)
vks('n', '<localleader>q', ':tabclose<cr>', opts)

-- I dont really like underlined text. Especially
-- in monospace font.
vim.api.nvim_set_hl(0, '@text.uri', { link = '@text' })

require('scripts/oil-as-netrw')
require('lazy-setup')

vim.cmd([[colorscheme tokyonight]])
