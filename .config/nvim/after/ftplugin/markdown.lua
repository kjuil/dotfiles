vim.opt_local.wrap = true
vim.opt_local.linebreak = true

vim.lsp.enable("marksman")

require("nvim-treesitter").install({ "markdown" })

vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

require("render-markdown").setup({
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
    anti_conceal = { disabled_modes = { "n" } },
    win_options = { concealcursor = { rendered = "nvc" } },
    completions = { blink = { enabled = true }, lsp = { enabled = true } },
})

vim.keymap.set("n", "<leader>mr", function() require("render-markdown").toggle() end,
    { desc = "Markdown render toggle" })
vim.keymap.set("n", "<leader>mp", function() require("render-markdown").preview() end,
    { desc = "Markdown preview toggle" })
