return {
    {
        "nvim-treesitter/nvim-treesitter",
        main = "nvim-treesitter.configs",
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                "c",
                "cpp",
                "lua",
                --"python",
                --"html",
            },
            sync_install = true,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
}
