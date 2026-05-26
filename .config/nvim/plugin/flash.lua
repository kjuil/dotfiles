vim.schedule(function()
    vim.pack.add({ "https://github.com/folke/flash.nvim" })

    vim.keymap.set("n", "<leader>fs", function() require("flash").jump() end, { desc = "Flash Jump" })
    vim.keymap.set("n", "<leader>ft", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
end)
