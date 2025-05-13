return {
    {
        "kawre/leetcode.nvim",
        cmd = "Leet",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            cn = {
                enabled = true,
                translator = true,
                translate_problems = true,
            },
        },
    },
}
