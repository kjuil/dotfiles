return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {
            completion = {
                menu = {
                    border = "rounded",
                    auto_show = true,
                    -- draw = {
                    --     columns = {
                    --         { "label", "label_description", gap = 1 },
                    --         { "kind_icon", "kind" },
                    --     },
                    -- },
                },
                documentation = {
                    window = {
                        border = "rounded",
                    },
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            },
            keymap = {
                preset = "super-tab",
            },
            sources = {
                default = { "path", "snippets", "buffer", "lsp" },
            },
        },
    },
}
