vim.api.nvim_create_autocmd("UIEnter", {
    group = vim.api.nvim_create_augroup("SurroundSetup", { clear = true }),
    once = true,
    callback = function()
        require("nvim-surround").setup({})
    end,
})
