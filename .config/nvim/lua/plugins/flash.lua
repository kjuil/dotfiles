return {
    {
        "folke/flash.nvim",
        keys = {
            { "<leader>fs", function() require("flash").jump() end,       desc = "Flash Jump" },
            { "<leader>ft", function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },
}
