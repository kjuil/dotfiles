return {
    {
        "mason-org/mason.nvim",
        opts = {
            github = { download_url_template = "https://bgithub.xyz/%s/releases/download/%s/%s" },
            ui = {
                icons = {
                    package_pending = " ",
                    package_installed = " ",
                    package_uninstalled = " ",
                },
            },
        },
        keys = {
            { "<leader>lm", "<CMD>Mason<CR>", desc = "Mason" },
        },
    }
}
