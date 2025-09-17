return {
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                opts = {
                    stages = "fade_in_slide_out",
                    timeout = 1000,
                    render = "wrapped-compact",
                    background_colour = "normal",
                    level = "INFO",
                },
            },
        },
        event = "VeryLazy",
        opts = {
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true,
            },
        },
    },
}
