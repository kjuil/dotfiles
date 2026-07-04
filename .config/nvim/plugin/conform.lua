vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("ConformSetup", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

        require("conform").setup({
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
            default_format_opts = { lsp_format = "fallback" },
            format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
            notify_on_error = true,
        })

        vim.o.formatexpr = "v:lua.require('conform').formatexpr()"

        vim.keymap.set("n", "<leader>lF", function() require("conform").format({ async = true }) end,
            { desc = "Formatter format" })
    end,
})
