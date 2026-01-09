vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("IBLSetup", { clear = true }),
    once = true,
    callback = function()
        require("ibl").setup({})
    end,
})
