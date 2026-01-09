vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
    group = vim.api.nvim_create_augroup("AutopairsSetup", { clear = true }),
    once = true,
    callback = function()
        require("nvim-autopairs").setup({})
    end,
})
