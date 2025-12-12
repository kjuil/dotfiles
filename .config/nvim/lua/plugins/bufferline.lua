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
                        filetype = "neo-tree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "center",
                    },
                },
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diagnostics_dict, _)
                    local indicator = " "
                    for level, number in pairs(diagnostics_dict) do
                        local symbol
                        if level == "error" then
                            symbol = " "
                        elseif level == "warning" then
                            symbol = " "
                        else
                            symbol = " "
                        end
                        indicator = indicator .. number .. symbol
                    end
                    return indicator
                end,
            },
            highlights = {
                buffer_selected = { italic = false, bold = true },
            },
        },
        keys = {
            { "<leader>bp", "<cmd>BufferLineCyclePrev<CR>",   desc = "BufferPrev" },
            { "<leader>bn", "<cmd>BufferLineCycleNext<CR>",   desc = "BufferNext" },
            { "<leader>bd", "<cmd>bdelete<CR>",               desc = "BufferClose" },
            { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "BufferCloseOthers" },
            { "<leader>bs", "<cmd>BufferLinePick<CR>",        desc = "BufferSelect" },
            { "<leader>bc", "<cmd>BufferLinePickClose<CR>",   desc = "BufferSelectClose" },
            { "<leader>bt", "<cmd>BufferLineTogglePin<CR>",   desc = "BufferTogglePin" },
        },
    },
}
