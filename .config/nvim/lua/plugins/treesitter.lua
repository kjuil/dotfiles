vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
    callback = function()
        require("nvim-treesitter.config").setup({
            ensure_installed = { "lua", "c", "cpp" },
            ignore_install = {},
            sync_install = true,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
})
