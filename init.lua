local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

vim.opt.nu = true
vim.opt.relativenumber = true
vim.cmd ":set nofixendofline"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.errorbells = false

vim.opt.colorcolumn = "180"

vim.opt.pumheight = 30

vim.opt.updatetime = 50
vim.opt.termguicolors = true
vim.opt.spell = true
vim.opt.hlsearch = true
vim.opt.spelllang = "en_us", "pl_pl"
