local o = vim.opt
local g = vim.g

o.shortmess = 'filnxtToOFI'

g.netrw_banner = 0

g.mapleader = ' '
g.maplocalleader = '.'

g.loaded_python3_provider = false
g.loaded_node_provider = false
g.loaded_perl_provider = false
g.loaded_ruby_provider = false

o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true
o.smartindent = true

o.termguicolors = true
o.number = true
-- o.relativenumber = true
o.cursorline = true

o.signcolumn = 'no'
o.ls = 0

vim.cmd([[
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
]])

require('init-keymaps')
require('init-lazy')
