vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("RainbowSetup", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/HiPhish/rainbow-delimiters.nvim" }, { load = false })

        require("rainbow-delimiters.setup").setup({})
    end,
})
