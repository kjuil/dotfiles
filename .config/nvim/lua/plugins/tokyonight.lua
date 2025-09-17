return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },

                    -- "dark", "transparent" or "normal"
                    sidebars = "dark",
                    floats = "dark",
                },
            })
            vim.cmd.colorscheme("tokyonight-moon")
        end,
    },
}
