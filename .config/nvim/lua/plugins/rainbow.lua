vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("RainbowSetup", { clear = true }),
    once = true,
    callback = function()
        require("rainbow-delimiters.setup").setup({})
    end,
})
