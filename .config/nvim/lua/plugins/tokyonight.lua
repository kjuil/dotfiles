require("tokyonight").setup({
    style = "moon",
    light_style = "day",
    transparent = false,
    terminal_colors = true,
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "dark", -- "dark", "transparent" or "normal"
        floats = "dark",
    },
    day_brightness = 0.3,
    dim_inactive = false,
    lualine_bold = true,
})

vim.cmd.colorscheme("tokyonight-moon")
