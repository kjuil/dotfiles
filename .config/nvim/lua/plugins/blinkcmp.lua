vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
    group = vim.api.nvim_create_augroup("BlinkCmpSetup", { clear = true }),
    once = true,
    callback = function()
        require("blink.cmp").setup({
            keymap = {
                preset = "super-tab",
                ["<C-k>"] = {},
            },
            completion = {
                menu = { border = "rounded", auto_show = true, scrollbar = false },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = { border = "rounded", scrollbar = false },
                },
                ghost_text = { enabled = true },
            },
            cmdline = {
                completion = {
                    list = {
                        selection = {
                            preselect = false,
                            auto_insert = true,
                        }
                    },
                    menu = { auto_show = true },
                },
            },
            signature = { enabled = true },
            sources = {
                default = { "path", "snippets", "buffer", "lsp" },
            },
            fuzzy = { implementation = "lua" },
        })
    end
})
