return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                     ",
            }

            dashboard.section.buttons.val = {
                dashboard.button("e", "󰈙  > New", "<CMD>enew<CR>"),
                dashboard.button("s", "  > Search", "<CMD>Telescope find_files<CR>"),
                dashboard.button("r", "  > Recent", "<CMD>Telescope oldfiles<CR>"),
                dashboard.button("l", "󰒲  > Plugins", "<CMD>Lazy<CR>"),
                dashboard.button("c", "  > Config", "<CMD>cd ~/.config/nvim | :e init.lua<CR>"),
                dashboard.button("q", "󰿅  > Exit", "<CMD>qa<CR>"),
            }

            dashboard.section.footer.val = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
            end

            alpha.setup(dashboard.opts)
        end,
    },
}
