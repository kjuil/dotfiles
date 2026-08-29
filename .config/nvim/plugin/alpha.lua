vim.pack.add({ "https://github.com/goolord/alpha-nvim" })

local dashboard = require("alpha.themes.dashboard")

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
    dashboard.button("o", "  > Options", "<CMD>lcd " .. vim.fn.stdpath("config") .. "| e ./init.lua<CR>"),
    dashboard.button("q", "󰿅  > Exit", "<CMD>qa<CR>"),
}

dashboard.section.footer.val = function()
    local version = vim.version()
    local datetime_info = " " .. os.date("%m-%d-%Y") .. "   " .. os.date("%H:%M:%S")
    local plugins_info = "   Plugins " .. #vim.pack.get(nil, { info = false })
    local version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

    return datetime_info .. plugins_info .. version_info
end

dashboard.opts.layout = {
    { type = "padding", val = 2 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 2 },
    dashboard.section.footer,
    { type = "padding", val = 2 },
}

require("alpha").setup(dashboard.opts)
