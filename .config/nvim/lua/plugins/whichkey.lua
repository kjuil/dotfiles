return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>?", "<CMD>WhichKey<CR>", desc = "Keymaps", },
        },
        opts = {
            preset = "helix",
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader>a", group = "Ai", },
                    { "<leader>b", group = "Buffer", },
                    { "<leader>c", group = "Code", },
                    { "<leader>d", group = "Debug", },
                    { "<leader>f", group = "Find" },
                    { "<leader>g", group = "Git" },
                    { "<leader>l", group = "Lsp" },
                    { "<leader>t", group = "Test" },
                    { "g",         group = "Goto" },
                },
            },
        },
    },
}
