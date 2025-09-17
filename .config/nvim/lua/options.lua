vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.autoindent = true
vim.o.smartindent = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.list = true
vim.o.listchars = "space:·,tab:-->"

vim.o.wrap = false

vim.o.cursorline = true

vim.o.signcolumn = "auto"

vim.o.colorcolumn = "100"

vim.o.showmode = false

vim.o.termguicolors = true

vim.o.cmdheight = 1

vim.g.encoding = "UTF-8"
vim.o.fileencoding = "UTF-8"

vim.o.wildmenu = true
vim.o.pumheight = 10
vim.o.completeopt = "menuone,noselect,popup,fuzzy"

vim.o.mouse = "a"

vim.o.confirm = true

vim.o.autoread = true

vim.o.breakindent = true

vim.o.updatetime = 200

vim.o.scrolloff = 10
vim.o.sidescrolloff = 10

vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.o.inccommand = "split"

vim.o.winborder = "rounded"
