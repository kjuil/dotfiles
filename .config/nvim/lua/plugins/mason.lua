vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("MasonSetup", { clear = true }),
    once = true,
    callback = function()
        require("mason").setup({
            github = { download_url_template = "https://bgithub.xyz/%s/releases/download/%s/%s" },
            ui = {
                icons = {
                    package_pending = " ",
                    package_installed = " ",
                    package_uninstalled = " ",
                },
            },
        })
        vim.keymap.set("n", "<leader>lm", "<CMD>Mason<CR>", { desc = "Mason" })
    end,
})
