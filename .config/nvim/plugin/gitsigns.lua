vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("GitsignSetup", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

        require("gitsigns").setup()

        vim.keymap.set("n", "<leader>gn", "<CMD>Gitsigns next_hunk<CR>", { desc = "Git next hunk" })
        vim.keymap.set("n", "<leader>gp", "<CMD>Gitsigns prev_hunk<CR>", { desc = "Git prev hunk" })
        vim.keymap.set("n", "<leader>gP", "<CMD>Gitsigns preview_hunk<CR>", { desc = "Git preview hunk" })
        vim.keymap.set("n", "<leader>gs", "<CMD>Gitsigns stage_hunk<CR>", { desc = "Git stage hunk" })
        vim.keymap.set("n", "<leader>gu", "<CMD>Gitsigns undo_stage_hunk<CR>", { desc = "Git undo stage" })
        vim.keymap.set("n", "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "Git reset hunk" })
        vim.keymap.set("n", "<leader>gB", "<CMD>Gitsigns stage_buffer<CR>", { desc = "Git stage buffer" })
        vim.keymap.set("n", "<leader>gb", "<CMD>Gitsigns blame<CR>", { desc = "Git blame" })
        vim.keymap.set("n", "<leader>gl", "<CMD>Gitsigns blame_line<CR>", { desc = "Git blame line" })
    end,
})
