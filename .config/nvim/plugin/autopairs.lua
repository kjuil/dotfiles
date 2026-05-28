vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
    group = vim.api.nvim_create_augroup("AutopairSetup", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })

        require("nvim-autopairs").setup({})
    end
})
