vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("GitsignSetup", { clear = true }),
    once = true,
    callback = function()
        local gitsigns = require("gitsigns")
        vim.keymap.set("n", "<leader>gn", function() gitsigns.next_hunk() end, { desc = "Git next hunk" })
        vim.keymap.set("n", "<leader>gp", function() gitsigns.prev_hunk() end, { desc = "Git prev hunk" })
        vim.keymap.set("n", "<leader>gP", function() gitsigns.preview_hunk() end, { desc = "Git preview hunk" })
        vim.keymap.set("n", "<leader>gs", function() gitsigns.stage_hunk() end, { desc = "Git stage hunk" })
        vim.keymap.set("n", "<leader>gu", function() gitsigns.undo_stage_hunk() end, { desc = "Git undo stage" })
        vim.keymap.set("n", "<leader>gr", function() gitsigns.reset_hunk() end, { desc = "Git reset hunk" })
        vim.keymap.set("n", "<leader>gB", function() gitsigns.stage_buffer() end, { desc = "Git stage buffer" })
        vim.keymap.set("n", "<leader>gb", function() gitsigns.blame() end, { desc = "Git blame" })
        vim.keymap.set("n", "<leader>gl", function() gitsigns.blame_line() end, { desc = "Git blame_line" })
    end,
})
