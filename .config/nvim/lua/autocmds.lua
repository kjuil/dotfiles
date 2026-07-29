vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight copying text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 300 })
    end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     desc = "Format on save",
--     group = vim.api.nvim_create_augroup("format-files", { clear = true }),
--     callback = function()
--         if vim.lsp.buf_is_attached then
--             vim.lsp.buf.format()
--         end
--     end,
-- })

vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Restore last editing position when opening a file",
    group = vim.api.nvim_create_augroup("restore-editing-position", { clear = true }),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Disable auto comment in the next line and preline",
    pattern = "*",
    group = vim.api.nvim_create_augroup("disable-auto-comment", { clear = true }),
    callback = function()
        vim.opt.formatoptions:remove("ro")
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Display a message when the current file is not in utf-8 format.",
    pattern = "*",
    group = vim.api.nvim_create_augroup("non_utf8_file", { clear = true }),
    callback = function()
        if vim.bo.fileencoding ~= "utf-8" then
            vim.notify("File not in UTF-8 format!", vim.log.levels.WARN, { title = "nvim-config" })
        end
    end,
})
