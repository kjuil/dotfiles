vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("WhichkeySetup", { clear = true }),
    once = true,
    callback = function()
        require("which-key").setup({
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
        })

        vim.keymap.set("n", "<leader>?", function() require("which-key").show({ global = false }) end,
            { desc = "Local Keymaps" })
    end,
})
