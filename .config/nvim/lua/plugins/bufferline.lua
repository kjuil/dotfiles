vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BufferlineSetup", { clear = true }),
    once = true,
    callback = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                separator_style = "slant",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "center",
                    },
                },
                -- diagnostics = "nvim_lsp",
                -- diagnostics_indicator = function(_, _, diagnostics_dict, _)
                --     local indicator = ""
                --     for level, number in pairs(diagnostics_dict) do
                --         local symbol
                --         if level == "error" then
                --             symbol = " "
                --         elseif level == "warning" then
                --             symbol = " "
                --         else
                --             symbol = " "
                --         end
                --         indicator = indicator .. number .. symbol
                --     end
                --     return indicator
                -- end,
            },
            highlights = { buffer_selected = { italic = false, bold = true }, },
        })
        vim.keymap.set("n", "<tab>", "<CMD>BufferLineCycleNext<CR>", { desc = "Buffer next" })
        vim.keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Buffer prev" })
        vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Buffer close" })
        vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Buffer close others" })
        vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { desc = "Buffer close select" })
        vim.keymap.set("n", "<leader>bs", "<cmd>BufferLinePick<CR>", { desc = "Buffer select" })
        vim.keymap.set("n", "<leader>bt", "<cmd>BufferLineTogglePin<CR>", { desc = "Buffer pin toggle" })
    end
})
