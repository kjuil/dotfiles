vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight Copying Text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 500 })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Format On Save",
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end,
})
