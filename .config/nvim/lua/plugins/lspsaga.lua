return {
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        cmd = { "Lspsaga" },
        opts = {},
        keys = {
            { "<leader>lds", "<CMD>Lspsaga show_buf_diagnostics<CR>",  desc = "Lsp show diagnostics" },
            { "<leader>ldn", "<CMD>Lspsaga diagnostics_jump_next<CR>", desc = "Lsp next diagnostics" },
            { "<leader>ldp", "<CMD>Lspsaga diagnostics_jump_prev<CR>", desc = "Lsp prev diagnostics" },
            { "<leader>lh",  "<CMD>Lspsaga hover_doc<CR>",             desc = "Lsp hover" },
            { "<leader>lo",  "<CMD>Lspsaga outline<CR>",               desc = "Lsp outline" },
            { "<C-t>",       "<CMD>Lspsaga term_toggle<CR>",           mode = { "n", "t" },          desc = "Terminal" },
        },
    },
}
