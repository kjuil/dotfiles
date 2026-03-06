return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local dashboard = require("alpha.themes.dashboard")
            local alpha = require("alpha")

            dashboard.section.header.val = {
                "                                                                       ",
                "                                                                     ",
                "       ████ ██████           █████      ██                     ",
                "      ███████████             █████                             ",
                "      █████████ ███████████████████ ███   ███████████   ",
                "     █████████  ███    █████████████ █████ ██████████████   ",
                "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
                "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
                " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
                "                                                                       ",
            }

            dashboard.section.buttons.val = {
                dashboard.button("n", "󰈙  > New", "<CMD>enew<CR>"),
                dashboard.button("f", "  > Search", "<CMD>Telescope find_files<CR>"),
                dashboard.button("r", "  > Recent", "<CMD>Telescope oldfiles<CR>"),
                dashboard.button("p", "󰒲  > Plugins", "<CMD>Lazy<CR>"),
                dashboard.button("o", "  > Options", "<CMD>e " .. vim.fn.stdpath("config") .. "/init.lua<CR>"),
                dashboard.button("q", "󰿅  > Exit", "<CMD>qa<CR>"),
            }

            dashboard.section.footer.val = function()
                local stats = require("lazy").stats()
                local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
                return { " ", " Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins  in " .. ms .. "ms" }
            end

            alpha.setup(dashboard.opts)
        end,
    },
}
