vim.schedule(function()
    vim.pack.add({ "https://github.com/mason-org/mason.nvim" })

    require("mason").setup({
        -- github = { download_url_template = "https://bgithub.xyz/%s/releases/download/%s/%s" },
        ui = {
            icons = {
                package_pending = " ",
                package_installed = " ",
                package_uninstalled = " ",
            },
        },
    })

    vim.keymap.set("n", "<leader>lm", "<CMD>Mason<CR>", { desc = "Mason" })
end)
