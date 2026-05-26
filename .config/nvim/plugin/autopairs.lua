vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("AutopairSetup", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/windwp/nvim-autopairs" }, { load = false })
        require("nvim-autopairs").setup({})
    end
})
