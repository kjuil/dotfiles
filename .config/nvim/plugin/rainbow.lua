vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("RainbowSetup", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/HiPhish/rainbow-delimiters.nvim" })

        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = 'rainbow-delimiters.strategy.global',
                vim = 'rainbow-delimiters.strategy.local',
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            priority = {
                [''] = 110,
                lua = 210,
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
        }
    end,
})
