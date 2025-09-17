local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-t>", "<CMD>split term://bash<CR>", opts)
vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:bdelete! %<CR>", opts)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", opts)

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("Terminal", { clear = true }),
    pattern = "*",
    callback = function()
        vim.o.cursorline = false
        vim.cmd [[resize 8]]
        vim.cmd [[normal i]]
    end
})
