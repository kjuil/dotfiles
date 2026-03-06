return {
    {
        "akinsho/bufferline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
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
                --     local indicator = " "
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
            highlights = { buffer_selected = { italic = false, bold = true } },
        },
        keys = {
            { "<Tab>",      "<CMD>BufferLineCycleNext<CR>",   desc = "Buffer next" },
            { "<S-Tab>",    "<CMD>BufferLineCyclePrev<CR>",   desc = "Buffer prev" },
            { "<leader>bd", "<CMD>bdelete<CR>",               desc = "Buffer close" },
            { "<leader>bo", "<CMD>BufferLineCloseOthers<CR>", desc = "Buffer close others" },
            { "<leader>bc", "<CMD>BufferLinePickClose<CR>",   desc = "Buffer close select" },
            { "<leader>bs", "<CMD>BufferLinePick<CR>",        desc = "Buffer select" },
            { "<leader>bt", "<CMD>BufferLineTogglePin<CR>",   desc = "Buffer pin toggle" },
        },
    },
}
