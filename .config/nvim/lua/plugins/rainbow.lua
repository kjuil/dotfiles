return {
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "rainbow-delimiters.setup",
        opts = {},
    },
}
