return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "Telescope" },
        keys = {
            { "<leader>ff",  "<CMD>Telescope find_files<CR>",                desc = "Telescope find files", },
            { "<leader>fw",  "<CMD>Telescope live_grep<CR>",                 desc = "Telescope live grep", },
            { "<leader>fb",  "<CMD>Telescope buffers<CR>",                   desc = "Telescope find buffers", },
            { "<leader>fh",  "<CMD>Telescope help_tags<CR>",                 desc = "Telescope help page", },
            { "<leader>fo",  "<CMD>Telescope oldfiles<CR>",                  desc = "Telescope current files", },
            { "<leader>fm",  "<CMD>Telescope marks<CR>",                     desc = "Telescope find marks", },
            { "<leader>fz",  "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope fuzzy find", },
            { "<leader>fgc", "<CMD>Telescope git_commits<CR>",               desc = "Telescope git commits", },
            { "<leader>fgs", "<CMD>Telescope git_status<CR>",                desc = "Telescope git status", },
        },
    },
}
