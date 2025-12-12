return {
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = { "rafamadriz/friendly-snippets" },
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {
            keymap = { preset = "super-tab", },
            cmdline = {
                completion = {
                    list = {
                        selection = {
                            preselect = false,
                            auto_insert = true,
                        }
                    },
                    menu = { auto_show = true, },
                },
            },
            completion = {
                menu = { border = "rounded", auto_show = true, },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = { border = "rounded", },
                },
                ghost_text = { enabled = false },
            },
            signature = { enabled = true },
            sources = {
                default = { "path", "snippets", "buffer", "lsp" },
            },
        },
    },
}
