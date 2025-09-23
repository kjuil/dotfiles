local function mode()
    local modes_map = {
        ["n"]     = "NORMAL",
        ["no"]    = "O-PENDING",
        ["nov"]   = "O-PENDING",
        ["noV"]   = "O-PENDING",
        ["no\22"] = "O-PENDING",
        ["niI"]   = "NORMAL",
        ["niR"]   = "NORMAL",
        ["niV"]   = "NORMAL",
        ["nt"]    = "NORMAL",
        ["ntT"]   = "NORMAL",
        ["v"]     = "VISUAL",
        ["vs"]    = "VISUAL",
        ["V"]     = "V-LINE",
        ["Vs"]    = "V-LINE",
        ["\22"]   = "V-BLOCK",
        ["\22s"]  = "V-BLOCK",
        ["s"]     = "SELECT",
        ["S"]     = "S-LINE",
        ["\19"]   = "S-BLOCK",
        ["i"]     = "INSERT",
        ["ic"]    = "INSERT",
        ["ix"]    = "INSERT",
        ["R"]     = "REPLACE",
        ["Rc"]    = "REPLACE",
        ["Rx"]    = "REPLACE",
        ["Rv"]    = "V-REPLACE",
        ["Rvc"]   = "V-REPLACE",
        ["Rvx"]   = "V-REPLACE",
        ["c"]     = "COMMAND",
        ["cv"]    = "EX",
        ["ce"]    = "EX",
        ["r"]     = "REPLACE",
        ["rm"]    = "MORE",
        ["r?"]    = "CONFIRM",
        ["!"]     = "SHELL",
        ["t"]     = "TERMINAL",
    }
    local current_mode = vim.api.nvim_get_mode().mode
    return modes_map[current_mode] or modes_map[string.sub(current_mode, 1, 1)] or "UNK"
end

local function filename()
    local fname = vim.fn.expand "%:t"
    if fname == "" then
        return "[No Name]"
    end
    return fname .. "%m"
end

local function diagnostic()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint",
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

    if count["errors"] ~= 0 then
        errors = " %#LspDiagnosticsSignError# " .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = " %#LspDiagnosticsSignInformation#󰌶 " .. count["info"]
    end

    return errors .. warnings .. hints .. info
end

local function filetype()
    return string.format(" %s ", vim.bo.filetype):lower()
end

function PickBuffer(buf_id)
    local window = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(window, buf_id)
end

function Set_tabline()
    local tabline = ""

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
            local edited = vim.bo.modified and "*" or " "
            local f_name = vim.api.nvim_buf_get_name(buf):match("^.+[\\/](.+)$") or ""
            if f_name == "" then f_name = "[No Name]" end

            local s = vim.api.nvim_get_current_buf() == buf
            tabline = tabline .. "%#TabLine" .. (s and "Sel" or "") .. "#" ..
                "┃   " .. "%" .. buf .. "@v:lua.PickBuffer@" .. f_name .. (s and edited or " ") .. "  %X✗%X" .. " "
        end
    end

    return tabline .. "%#TabLine#%=" .. ""
end

Statusline = {}

Statusline.active = function()
    return " |"..mode().."| "..
        filename()..
        diagnostic()..
        "%="..
        filetype()..
        " %P %l:%c "
end

Statusline.inactive = function()
    return " %F"
end

Statusline.netrw = function()
    return "  Netrw"
end

vim.cmd [[
    augroup Statusline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
    autocmd WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
    autocmd FileType netrw setlocal statusline=%!v:lua.Statusline.netrw()
    augroup END
]]

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("Buffer", { clear = true }),
    pattern = "*",
    callback = function()
        vim.o.tabline = "%!v:lua.Set_tabline()"
        vim.o.showtabline = 2

        vim.keymap.set("n", "<leader>bn", "<CMD>bnext<CR>", { desc = "Buffer next" })
        vim.keymap.set("n", "<leader>bp", "<CMD>bprev<CR>", { desc = "Buffer previous" })
        vim.keymap.set("n", "<leader>bd", "<CMD>bdelete<CR>", { desc = "Buffer delete" })
    end
})

