vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight copying text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 300 })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Format on save",
    callback = function()
        if vim.lsp.buf_is_attached then
            vim.lsp.buf.format()
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Disable auto comment in the next line and preline",
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove("ro")
    end,
})
