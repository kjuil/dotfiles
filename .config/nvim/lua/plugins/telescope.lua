vim.api.nvim_create_autocmd("UIEnter", {
    group = vim.api.nvim_create_augroup("TelescopeSetup", { clear = true }),
    once = true,
    callback = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope find buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help page" })
        vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope find oldfiles" })
        vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Telescope find marks" })
        vim.keymap.set("n", "<leader>fz", builtin.current_buffer_fuzzy_find, { desc = "Telescope fuzzy find" })
        vim.keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "Telescope git commits" })
        vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "Telescope git status" })
    end,
})
