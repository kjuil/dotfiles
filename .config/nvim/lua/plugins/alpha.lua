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
    dashboard.button("e", "󰈙  > New file", "<CMD>enew<CR>"),
    dashboard.button("s", "  > Search file", "<CMD>Telescope find_files<CR>"),
    dashboard.button("r", "  > Recent file", "<CMD>Telescope oldfiles<CR>"),
    dashboard.button("o", "  > Option", "<CMD>e ~/.config/nvim/init.lua<CR>"),
    dashboard.button("q", "󰿅  > Quit", "<CMD>qa<CR>"),
}

dashboard.section.footer.val = function()
    local footer = ""
    local handle = io.popen("fortune")
    if handle then
        footer = footer .. handle:read("*a")
        handle:close()
    else
        footer = "Welcome!"
    end
    return footer
end

dashboard.config.layout = {
    { type = "padding", val = 2 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 3 },
    dashboard.section.footer,
    { type = "padding", val = 2 },
}

require("alpha").setup(dashboard.config)
