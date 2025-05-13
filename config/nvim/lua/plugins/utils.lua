return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            close_if_last_window = true,
            window = {
                position = "left",
                width = 30,
            },
        },
        keys = {
            {
                "<leader>e",
                "<CMD>Neotree toggle<CR>",
                desc = "Neotree",
            },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>ff",
                "<CMD>Telescope find_files<CR>",
                desc = "Telescope find files",
            },

            {
                "<leader>fg",
                "<CMD>Telescope live_grep<CR>",
                desc = "Telescope live grep",
            },

            {
                "<leader>fb",
                "<CMD>Telescope buffers<CR>",
                desc = "Telescope buffers",
            },

            {
                "<leader>fh",
                "<CMD>Telescope help_tags<CR>",
                desc = "Telescope help tags",
            },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
        },
        keys = {
            {
                "<leader>?",
                "<CMD>WhichKey<CR>",
                desc = "Local Keymaps",
            },
        },
    },

    {
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        opts = {
            size = 13,
            open_mapping = [[<C-t>]],
            hide_numbers = true,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            close_on_exit = true,
            direction = "horizontal", --"float","horizontal","vertical"
            shell = vim.o.shell,
        },
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        opts = {},
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },
}
