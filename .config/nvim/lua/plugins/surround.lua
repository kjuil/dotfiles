vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("SurroundSetup", { clear = true }),
    once = true,
    callback = function()
        require("nvim-surround").setup({})
    end,
})
