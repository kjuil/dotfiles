vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("basedpyright")
vim.lsp.enable("marksman")

vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lspattach", { clear = true }),
    callback = function(event)
        vim.keymap.set("n", "grd", "<CMD>lua vim.lsp.buf.definition()<CR>", { desc = "Goto Definition" })
        vim.keymap.set("n", "grD", "<CMD>lua vim.lsp.buf.declaration()<CR>", { desc = "Goto Declaration" })
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Lsp Format" })
        vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic List" })
        vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Diagnostic Next" })
        vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Diagnostic Prev" })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method "textDocument/foldingRange" then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>lih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { buffer = event.buf, desc = "LSP Inlay Hints" })
        end
    end,
})
