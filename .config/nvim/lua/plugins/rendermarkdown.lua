return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ft = { "markdown" },
        keys = {
            { "<leader>m", "<cmd>RenderMarkdown toggle<cr>", desc = "Markdown Render" },
        },
        opts = {
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
            pipe_table = { border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" }, },
            dash = { width = 100, },
            anti_conceal = { disabled_modes = { "n" }, },
            win_options = { concealcursor = { rendered = "nvc" } },
            completions = { blink = { enabled = true }, lsp = { enabled = true }, },
        },
    },
}
