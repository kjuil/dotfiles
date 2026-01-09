vim.api.nvim_create_autocmd("UIEnter", {
    group = vim.api.nvim_create_augroup("FlashSetup", { clear = true }),
    once = true,
    callback = function()
        local flash = require("flash")
        vim.keymap.set("n", "<leader>fs", function() flash.jump() end, { desc = "Flash Jump" })
        vim.keymap.set("n", "<leader>ft", function() flash.treesitter() end, { desc = "Flash Treesitter" })
    end,
})
