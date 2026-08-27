vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape insert mode" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete a word" })

vim.keymap.set("n", ";", ":", { desc = "Enter command mode" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Goto window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Goto window right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Goto window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Goto window up" })

vim.keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "<C-s>", "<CMD>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<C-a>", "gg0vG$", { desc = "Select all" })
vim.keymap.set("n", "<CR>", "za", { desc = "Toggle fold under cursor" })

vim.keymap.set("n", "<C-t>", "<CMD>" .. math.floor(vim.o.lines * 0.3) .. "split | terminal<CR>",
    { desc = "Termianl toggle" })
vim.keymap.set("t", "<C-t>", "<C-\\><C-N><CMD>bdelete!<CR>", { desc = "Termianl toggle" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Escape terminal mode" })
