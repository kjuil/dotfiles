local repo = "https://bgithub.xyz/"

vim.pack.add({
    { src = repo .. "folke/tokyonight.nvim" },
    { src = repo .. "goolord/alpha-nvim" },
    { src = repo .. "nvim-lualine/lualine.nvim" },
    { src = repo .. "akinsho/bufferline.nvim" },
    { src = repo .. "nvim-treesitter/nvim-treesitter" },
    { src = repo .. "nvim-tree/nvim-tree.lua" },
    { src = repo .. "nvim-tree/nvim-web-devicons" },
    { src = repo .. "saghen/blink.cmp" },
    { src = repo .. "rafamadriz/friendly-snippets" },
    { src = repo .. "kylechui/nvim-surround" },
    { src = repo .. "windwp/nvim-autopairs" },
    { src = repo .. "nvim-telescope/telescope.nvim" },
    { src = repo .. "nvim-lua/plenary.nvim" },
    { src = repo .. "folke/flash.nvim", },
    { src = repo .. "folke/which-key.nvim" },
    { src = repo .. "stevearc/conform.nvim" },
    { src = repo .. "lewis6991/gitsigns.nvim" },
    { src = repo .. "lukas-reineke/indent-blankline.nvim" },
    { src = repo .. "HiPhish/rainbow-delimiters.nvim" },
    { src = repo .. "MeanderingProgrammer/render-markdown.nvim" },
    { src = repo .. "mason-org/mason.nvim" },
})

require("plugins.tokyonight")
require("plugins.alpha")
require("plugins.lualine")
require("plugins.bufferline")
require("plugins.treesitter")
require("plugins.blinkcmp")
require("plugins.nvimtree")
require("plugins.telescope")
require("plugins.flash")
require("plugins.conform")
require("plugins.whichkey")
require("plugins.gitsigns")
require("plugins.autopairs")
require("plugins.surround")
require("plugins.ibl")
require("plugins.rainbow")
require("plugins.rendermarkdown")
require("plugins.mason")
