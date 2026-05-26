vim.schedule(function()
    vim.pack.add({ "https://github.com/folke/which-key.nvim" })

    require("which-key").setup({
        preset = "helix",
        spec = {
            {
                mode = { "n", "v" },
                { "<leader>a", group = "Ai" },
                { "<leader>b", group = "Buffer" },
                { "<leader>c", group = "Code" },
                { "<leader>d", group = "Debug" },
                { "<leader>f", group = "Find" },
                { "<leader>g", group = "Git" },
                { "<leader>l", group = "Lsp" },
                { "<leader>m", group = "Markdown" },
                { "<leader>t", group = "Test" },
                { "g",         group = "Goto" },
            },
        },
    })

    vim.keymap.set("n", "<leader>?", function() require("which-key").show({ global = false }) end,
        { desc = "Local Keymaps" })
end)
