require("lualine").setup({
    options = {
        theme = "auto",
        globalstatus = true,
        component_separators = "|",
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { { "mode", separator = { left = "" } } },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename", "diagnostics", },
        lualine_x = { "lsp_status", "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { { "location", separator = { right = "" } }, },
    },
})
