return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            ensure_installed = { "lua", "c", "cpp" },
            ignore_install = {},
            sync_install = true,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
}
