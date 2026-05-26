vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspsagaSetup", { clear = true }),
    once = true,
    callback = function()
        vim.pack.add({ "https://github.com/nvimdev/lspsaga.nvim" })
        require("lspsaga").setup({})

        vim.keymap.set("n", "K", "<CMD>Lspsaga hover_doc<CR>", { desc = "LSP hover doc" })
        vim.keymap.set("n", "gd", "<CMD>Lspsaga goto_definition<CR>", { desc = "LSP goto definition" })
        vim.keymap.set("n", "gp", "<CMD>Lspsaga peek_definition<CR>", { desc = "LSP peek definition" })
        vim.keymap.set("n", "gr", "<CMD>Lspsaga rename<CR>", { desc = "LSP rename" })
        vim.keymap.set("n", "ga", "<CMD>Lspsaga code_action<CR>", { desc = "LSP code action" })
        vim.keymap.set("n", "gh", "<CMD>Lspsaga finder<CR>", { desc = "LSP finder" })
        vim.keymap.set("n", "<leader>cd", "<CMD>Lspsaga show_line_diagnostics<CR>", { desc = "LSP line diagnostics" })
        vim.keymap.set("n", "[e", "<CMD>Lspsaga diagnostic_jump_prev<CR>", { desc = "LSP prev diagnostic" })
        vim.keymap.set("n", "]e", "<CMD>Lspsaga diagnostic_jump_next<CR>", { desc = "LSP next diagnostic" })
        vim.keymap.set("n", "<leader>lo", "<CMD>Lspsaga outline<CR>", { desc = "LSP outline" })
    end
})
