vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("IndentSetup", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })

        require("ibl").setup({})
    end,
})
