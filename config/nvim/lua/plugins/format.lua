return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ async = true })
                end,
                mode = "",
                desc = "Format",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                -- python = { "isort", "black" },
                -- javascript = { "prettierd", "prettier", stop_after_first = true },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            format_on_save = { timeout_ms = 500 },
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
            },
        },
    },
}
