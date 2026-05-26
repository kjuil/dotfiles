vim.lsp.enable({ "lua_ls", "clangd", "basedpyright" })

vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
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
        vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Goto definition" })
        vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Lsp format" })
        vim.keymap.set("n", "<leader>lds", vim.diagnostic.setloclist, { desc = "Lsp diagnostic show" })
        vim.keymap.set("n", "<leader>ldn", vim.diagnostic.goto_next, { desc = "Lsp diagnostic next" })
        vim.keymap.set("n", "<leader>ldp", vim.diagnostic.goto_prev, { desc = "Lsp diagnostic prev" })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method "textDocument/foldingRange" then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>lih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { buffer = event.buf, desc = "LSP inlay hints" })
        end
    end,
})
