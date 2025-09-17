return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                component_separators = "|",
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { { "mode", separator = { left = "" } } },
                lualine_b = {
                    { "branch", separator = { right = "" } },
                    { "diff", separator = { right = "" } },
                },
                lualine_c = { "diagnostics", "lsp_status", "filename", },
                lualine_x = { "encoding", "filetype" },
                lualine_y = { { "progress", separator = { left = "" } }, },
                lualine_z = { { "location", separator = { right = "" } }, },
            },
        },
    },
}
