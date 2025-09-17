return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", },
        cmd = { "Telescope" },
        keys = {
            { "<leader>fb", "<CMD>Telescope buffers<CR>",    desc = "Buffers", },
            { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find Files", },
            { "<leader>fg", "<CMD>Telescope live_grep<CR>",  desc = "Live Grep", },
            { "<leader>fh", "<CMD>Telescope help_tags<CR>",  desc = "Help Tags", },
            { "<leader>fo", "<CMD>Telescope oldfiles<CR>",   desc = "Recent Files", },
        },
    },
}
