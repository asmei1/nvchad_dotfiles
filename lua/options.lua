require "nvchad.options"

local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})
-- vim.cmd [[
-- augroup filetypedetect
--   autocmd!
--   " Set .md files to use markdown syntax
--   autocmd BufNewFile,BufRead *.md set syntax=markdown
-- augroup END
-- ]]
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
vim.opt.spelllang = en_us
vim.g.python3_host_prog = "/usr/bin/python3"
