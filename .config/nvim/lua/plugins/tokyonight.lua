return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
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

            if vim.g.neovide then
                vim.o.guifont = "JetbrainsMono Nerd Font:h12"
                local bg = vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).bg
                local fg = vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).fg
                vim.g.neovide_title_background_color = string.format("%x", bg)
                vim.g.neovide_title_text_color = string.format("%x", fg)
                vim.g.neovide_hide_mouse_when_typing = true
            end
        end,
    },
}
