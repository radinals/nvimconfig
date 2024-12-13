
local opt = vim.opt

opt.number = true
opt.termguicolors = true
opt.swapfile = false
opt.relativenumber = true
opt.scrolloff = 999
opt.wrap = false
opt.swapfile = false
opt.undofile = true
opt.clipboard="unnamedplus"
opt.laststatus = 0

vim.cmd("colorscheme gruvbox-flat")

-- escape from terminal
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

