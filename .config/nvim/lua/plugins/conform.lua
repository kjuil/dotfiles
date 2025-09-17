return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Code Format", },
        },
        opts = {
            notify_on_error = true,
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                python = { "isort", "black" },
                sh = { "shfmt" },
                javascript = { "prettierd" },
                json = { "prettierd" },
                markdown = { "prettierd" },
            },
            default_format_opts = { lsp_format = "fallback", },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    },
}
