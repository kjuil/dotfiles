return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>e", "<CMD>Neotree toggle<CR>", desc = "Explorer", },
        },
        opts = {
            close_if_last_window = true,
            window = { width = 30, },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_hidden = false,
                    hide_excluded_files = false,
                },
                follow_current_file = { enabled = true, },
                group_empty_dirs = true,
                hijack_netrw = true,
            },
        },
    },
}
