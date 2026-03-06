return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            { "<leader>gn", "<CMD>Gitsigns next_hunk<CR>",       desc = "Git next hunk",    silent = true },
            { "<leader>gp", "<CMD>Gitsigns prev_hunk<CR>",       desc = "Git prev hunk",    silent = true },
            { "<leader>gP", "<CMD>Gitsigns preview_hunk<CR>",    desc = "Git preview hunk", silent = true },
            { "<leader>gs", "<CMD>Gitsigns stage_hunk<CR>",      desc = "Git stage hunk",   silent = true },
            { "<leader>gu", "<CMD>Gitsigns undo_stage_hunk<CR>", desc = "Git undo stage",   silent = true },
            { "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>",      desc = "Git reset hunk",   silent = true },
            { "<leader>gB", "<CMD>Gitsigns stage_buffer<CR>",    desc = "Git stage buffer", silent = true },
            { "<leader>gb", "<CMD>Gitsigns blame<CR>",           desc = "Git blame",        silent = true },
            { "<leader>gl", "<CMD>Gitsigns blame_line<CR>",      desc = "Git blame line",   silent = true },
        },
    },
}
