return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "moon",
                light_style = "day",
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false },
                    functions = {},
                    variables = {},
                    -- Background styles. "dark", "transparent" or "normal"
                    sidebars = "dark",
                    floats = "dark",
                },
                day_brightness = 0.3,
                dim_inactive = false,
                lualine_bold = true,
            })
            vim.cmd.colorscheme("tokyonight-moon")
        end,
    },

    { "nvim-lualine/lualine.nvim",   opts = {} },

    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "NeoTree",
                        highlight = "Directory",
                        text_align = "left",
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
        },
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                progress = {
                    enabled = false,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true,
            },
            messages = {
                enabled = true,
                view = "notify",
                view_error = "notify",
                view_warn = "notify",
                view_history = "messages",
                view_search = "virtualtext",
            },
            health = {
                checker = false,
            },
        },
    },

    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            -- "fade", "slide", "fade_in_slide_out", "static"
            stages = "fade",
            on_open = nil,
            on_close = nil,
            timeout = 1000,
            fps = 30,
            render = "default",
            background_colour = "normal",
            level = "TRACE",
        },
    },

    { "nvim-tree/nvim-web-devicons", lazy = true },

    { "nvim-lua/plenary.nvim",       lazy = true },

    { "MunifTanjim/nui.nvim",        lazy = true },
}
