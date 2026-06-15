vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("SurroundSetup", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/kylechui/nvim-surround" })

        require("nvim-surround").setup()
    end,
})
