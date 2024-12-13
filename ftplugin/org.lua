local opt = vim.opt_local
local cmd = vim.cmd

opt.foldlevel = 0
opt.foldlevelstart = 99
opt.foldenable = false
cmd("UfoDisable")

opt.wrap = true
-- opt.linebreak = true
-- opt.nofoldenable = true
opt.spell = true
opt.showbreak = "+++"
opt.colorcolumn = "80"
