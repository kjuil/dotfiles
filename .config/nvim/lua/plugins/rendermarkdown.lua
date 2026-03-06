return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ft = { "markdown" },
        keys = {
            { "<leader>mr", function() require("render-markdown").toggle() end,  desc = "Markdown render toggle" },
            { "<leader>mp", function() require("render-markdown").preview() end, desc = "Markdown preview toggle" },
        },
        opts = {
            file_types = { "markdown", "quarto", "help" },
            heading = {
                icons = { " 󰼏 ", " 󰎨 ", " 󰼑 ", " 󰎲 ", " 󰼓 ", " 󰎴 " },
                width = "block",
                min_width = 100,
                border = true,
            },
            code = {
                width = "block",
                min_width = 100,
                border = "thin",
                left_pad = 1,
                right_pad = 1,
                position = "right",
                language_icon = true,
                language_name = true,
            },
            sign = { enabled = false },
            pipe_table = { preset = "round" },
            dash = { width = 100 },
            anti_conceal = { disabled_modes = { "n" }, },
            win_options = { concealcursor = { rendered = "nvc" } },
            completions = { blink = { enabled = true }, lsp = { enabled = true } },
        },
    },
}
