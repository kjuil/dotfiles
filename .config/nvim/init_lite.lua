-- vim:fileencoding=utf-8:foldmethod=marker:foldlevel=0

-- Options {{{
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.list = true
vim.o.listchars = "space:·,tab:-->"
vim.o.wrap = false
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "100"
vim.o.showmode = false
vim.o.showcmd = true
vim.o.termguicolors = true
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "UTF-8"
vim.o.wildmenu = true
vim.o.completeopt = "menu,menuone,noselect,popup,fuzzy"
vim.o.mouse = "a"
vim.o.confirm = true
vim.o.autoread = true
vim.o.updatetime = 200
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.winborder = "rounded"
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

-- }}}

-- Keymaps {{{
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- }}}

-- Autocmds {{{
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        -- vim.cmd("colorscheme sorbet")
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight Copying Text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 300 })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Format On Save",
    pattern = "*",
    callback = function()
        vim.lsp.buf.format()
    end,
})

---}}}

-- Lspconfig {{{

vim.lsp.enable({ "lua_ls" })

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
    settings = {
        Lua = {
            codeLens = { enable = true },
            hint = { enable = true, semicolon = 'Disable' },
            diagnostics = { globals = { "vim" } },
        },
    },
})

vim.lsp.config("clangd", {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git",
    },
    single_file_support = true,
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { "utf-8", "utf-16" },
    },
})

vim.lsp.config("basedpyright", {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_makers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
    settings = {
        basedpyright = { analysis = { typeCheckingMode = "off" }, },
    },
})

vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    virtual_text = { spacing = 4, source = "if_many", prefix = "●", },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lspattach", { clear = true }),
    callback = function(event)
        vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Goto Definition" })
        vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Lsp Format" })
        vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic List" })
        vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Diagnostic Next" })
        vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Diagnostic Prev" })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method "textDocument/foldingRange" then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>li", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { buffer = event.buf, desc = "Lsp Inlay Hints" })
        end
    end,
})

-- }}}

-- Statusline {{{
local function modes()
    local modes_map = {
        ["n"]     = { text = "NORMAL", hl = "ModeNormal" },
        ["no"]    = { text = "O-PENDING", hl = "ModeNormal" },
        ["nov"]   = { text = "O-PENDING", hl = "ModeNormal" },
        ["noV"]   = { text = "O-PENDING", hl = "ModeNormal" },
        ["no\22"] = { text = "O-PENDING", hl = "ModeNormal" },
        ["niI"]   = { text = "NORMAL", hl = "ModeNormal" },
        ["niR"]   = { text = "NORMAL", hl = "ModeNormal" },
        ["niV"]   = { text = "NORMAL", hl = "ModeNormal" },
        ["nt"]    = { text = "NORMAL", hl = "ModeNormal" },
        ["ntT"]   = { text = "NORMAL", hl = "ModeNormal" },
        ["v"]     = { text = "VISUAL", hl = "ModeVisual" },
        ["vs"]    = { text = "VISUAL", hl = "ModeVisual" },
        ["V"]     = { text = "V-LINE", hl = "ModeVisual" },
        ["Vs"]    = { text = "V-LINE", hl = "ModeVisual" },
        ["\22"]   = { text = "V-BLOCK", hl = "ModeVisual" },
        ["\22s"]  = { text = "V-BLOCK", hl = "ModeVisual" },
        ["s"]     = { text = "SELECT", hl = "ModeVisual" },
        ["S"]     = { text = "S-LINE", hl = "ModeVisual" },
        ["\19"]   = { text = "S-BLOCK", hl = "ModeVisual" },
        ["i"]     = { text = "INSERT", hl = "ModeInsert" },
        ["ic"]    = { text = "INSERT", hl = "ModeInsert" },
        ["ix"]    = { text = "INSERT", hl = "ModeInsert" },
        ["R"]     = { text = "REPLACE", hl = "ModeReplace" },
        ["Rc"]    = { text = "REPLACE", hl = "ModeReplace" },
        ["Rx"]    = { text = "REPLACE", hl = "ModeReplace" },
        ["Rv"]    = { text = "V-REPLACE", hl = "ModeReplace" },
        ["Rvc"]   = { text = "V-REPLACE", hl = "ModeReplace" },
        ["Rvx"]   = { text = "V-REPLACE", hl = "ModeReplace" },
        ["c"]     = { text = "COMMAND", hl = "ModeCommand" },
        ["cv"]    = { text = "EX", hl = "ModeCommand" },
        ["ce"]    = { text = "EX", hl = "ModeCommand" },
        ["r"]     = { text = "REPLACE", hl = "ModeReplace" },
        ["rm"]    = { text = "MORE", hl = "ModeCommand" },
        ["r?"]    = { text = "CONFIRM", hl = "ModeCommand" },
        ["!"]     = { text = "SHELL", hl = "ModeShell" },
        ["t"]     = { text = "TERMINAL", hl = "ModeTerminal" },
    }
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_info = modes_map[current_mode] or modes_map[string.sub(current_mode, 1, 1)] or
        { text = "UNK", hl = "ErrorMsg" }
    return "%#" .. mode_info.hl .. "#" .. " --" .. mode_info.text .. "-- %*"
end

local function filename()
    local fname = vim.fn.expand "%:t"
    if fname == "" then
        return "[No Name]"
    end
    return fname .. "%h%w%m%r"
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
    local info = ""
    local hints = ""

    if count["errors"] ~= 0 then
        errors = "%#DiagnosticError# " .. count["errors"] .. "%* "
    end
    if count["warnings"] ~= 0 then
        warnings = "%#DiagnosticWarn# " .. count["warnings"] .. "%* "
    end
    if count["info"] ~= 0 then
        info = "%#DiagnosticInfo# " .. count["info"] .. "%* "
    end
    if count["hints"] ~= 0 then
        hints = "%#DiagnosticHint#󰌶 " .. count["hints"] .. "%* "
    end

    return "    " .. errors .. warnings .. hints .. info .. " "
end

local function filetype()
    return string.format(" %s ", vim.bo.filetype):lower()
end

function Active()
    return modes() .. filename() .. diagnostic() .. "%=" .. filetype() .. " %P %l:%c "
end

function Inactive()
    return " %F"
end

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    group = vim.api.nvim_create_augroup("statusline_active", { clear = true }),
    callback = function()
        if vim.bo.filetype ~= "netrw" then
            vim.opt_local.statusline = "%!v:lua.Active()"
        end
    end
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
    group = vim.api.nvim_create_augroup("statusline_inactive", { clear = true }),
    callback = function()
        if vim.bo.filetype ~= "netrw" then
            vim.opt_local.statusline = "%!v:lua.Inactive()"
        end
    end
})

-- }}}

-- Tabline {{{
function PickBuffer(buf)
    local window = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(window, buf)
end

function SetTab()
    local tabline_left = "%#TabLine#┃"
    local tabline_right = ""

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
            local edited = vim.bo.modified and "*" or " "
            local f_name = vim.api.nvim_buf_get_name(buf):match("^.+[\\/](.+)$") or "[No Name]"
            local padding = (18 - #f_name) / 2
            local padded_text = string.rep(" ", padding > 0 and padding or 0)

            local s = vim.api.nvim_get_current_buf() == buf
            tabline_left = tabline_left ..
                "%#TabLine" .. (s and "Sel#" or "#") ..
                " %" .. buf .. "@v:lua.PickBuffer@" ..
                padded_text .. f_name .. (s and edited or " ") .. padded_text ..
                "%#TabLine#┃"
        end
    end

    return tabline_left .. "%=" .. tabline_right
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("Buffer", { clear = true }),
    callback = function()
        vim.o.tabline = "%!v:lua.SetTab()"
        vim.o.showtabline = 2
        vim.keymap.set("n", "<leader>bn", "<CMD>bnext<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>bp", "<CMD>bprev<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>bd", "<CMD>bdelete<CR>", { noremap = true, silent = true })
    end
})

-- }}}

-- Netrw {{{
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3

vim.keymap.set("n", "<leader>e", "<CMD>Lexplore<CR>", { desc = "Netrw" })

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("netrw", { clear = true }),
    pattern = "netrw",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.keymap.set("n", "<C-l>", "<C-w>l", { buffer = buf, noremap = true })
        vim.opt_local.statusline = "  Netrw"
    end
})

-- }}}

-- Folding {{{
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

local function fold_virt_text(result, start_text, lnum)
    local text = ""
    local hl
    for i = 1, #start_text do
        local char = start_text:sub(i, i)
        local new_hl

        local sem_tokens = vim.lsp.semantic_tokens.get_at_pos(0, lnum, i - 1)
        if sem_tokens and #sem_tokens > 0 then
            new_hl = "@" .. sem_tokens[#sem_tokens].type
        else
            local captured_highlights = vim.treesitter.get_captures_at_pos(0, lnum, i - 1)
            if captured_highlights[#captured_highlights] then
                new_hl = "@" .. captured_highlights[#captured_highlights].capture
            end
        end

        if new_hl then
            if new_hl ~= hl then
                table.insert(result, { text, hl })
                text = ""
                hl = nil
            end
            text = text .. char
            hl = new_hl
        else
            text = text .. char
        end
    end
    table.insert(result, { text, hl })
end

function Foldtext()
    local start_text = vim.fn.getline(vim.v.foldstart):gsub("\t", string.rep(" ", vim.o.tabstop))
    local nline = vim.v.foldend - vim.v.foldstart
    local result = {}
    fold_virt_text(result, start_text, vim.v.foldstart - 1)
    table.insert(result, { "  ", nil })
    table.insert(result, { "󰛁  " .. nline .. " lines folded", "@comment" })
    return result
end

vim.opt.foldtext = "v:lua.Foldtext()"

vim.keymap.set("n", "<CR>", "za", { desc = "Toggle fold under cursor" })

-- }}}

-- Fterm {{{
local window = nil
local buffer = nil

local function create_term()
    local spawn_terminal = false
    if buffer == nil then
        buffer = vim.api.nvim_create_buf(false, true)
        spawn_terminal = true
    end

    window = vim.api.nvim_open_win(
        buffer,
        true,
        {
            relative = "editor",
            row = 2,
            col = 8,
            height = vim.o.lines - 7,
            width = vim.o.columns - 16,
            border = "rounded",
            title = "Terminal",
            title_pos = "left",
            style = "minimal",
        }
    )

    vim.api.nvim_create_autocmd("WinClosed", {
        buffer = buffer,
        callback = function()
            window = nil
        end,
    })

    if spawn_terminal then
        vim.fn.termopen(vim.o.shell or "/bin/sh", {
            on_exit = function()
                vim.api.nvim_win_close(window, false)
                window = nil
                buffer = nil
            end,
        })
    end
    vim.cmd("startinsert")
end

function Toggle_term()
    if window ~= nil then
        vim.api.nvim_win_close(window, false)
        window = nil
    else
        create_term()
    end
end

vim.keymap.set({ "n", "t" }, "<C-t>", function() Toggle_term() end, { desc = "FloatTerm" })

-- }}}

-- Autopairs {{{
local pairs_config = {
    keys = {
        ["("] = { escape = false, close = true, pair = "()" },
        ["["] = { escape = false, close = true, pair = "[]" },
        ["{"] = { escape = false, close = true, pair = "{}" },

        [">"] = { escape = true, close = false, pair = "<>" },
        [")"] = { escape = true, close = false, pair = "()" },
        ["]"] = { escape = true, close = false, pair = "[]" },
        ["}"] = { escape = true, close = false, pair = "{}" },

        ['"'] = { escape = true, close = true, pair = '""' },
        ["'"] = { escape = true, close = true, pair = "''" },
        ["`"] = { escape = true, close = true, pair = "``" },

        [" "] = { escape = false, close = true, pair = "  " },

        ["<BS>"] = {},
        ["<CR>"] = { disable_command_mode = true },
    },
    options = {
        pair_spaces = false,
        auto_indent = true,
        disable_command_mode = true,
    },
}

local function insert_get_pair()
    local line = "_" .. vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1

    return line:sub(col, col + 1)
end

local function command_get_pair()
    local line = "_" .. vim.fn.getcmdline()
    local col = vim.fn.getcmdpos()

    return line:sub(col, col + 1)
end

local function is_pair(pair)
    if pair == "  " then
        return false
    end

    for _, info in pairs(pairs_config.keys) do
        if pair == info.pair then
            return true
        end
    end
    return false
end

local function handler(key, info, mode)
    local pair = mode == "insert" and insert_get_pair() or command_get_pair()

    if (key == "<BS>") and is_pair(pair) then
        return "<BS><Del>"
    elseif
        mode == "insert" and key == "<CR>" and is_pair(pair) then
        return "<CR><ESC>O" .. (pairs_config.options.auto_indent and "" or "<C-D>")
    elseif info.escape and pair:sub(2, 2) == key then
        return mode == "insert" and "<C-G>U<Right>" or "<Right>"
    elseif info.close then
        if
            key == " "
            and (
                not pairs_config.options.pair_spaces
                or (pairs_config.options.pair_spaces and not is_pair(pair))
                or pair:sub(1, 1) == pair:sub(2, 2)
            )
        then
            return key
        end

        return info.pair .. (mode == "insert" and "<C-G>U<Left>" or "<Left>")
    else
        return key
    end
end

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
    group = vim.api.nvim_create_augroup("autopairs", { clear = true }),
    once = true,
    callback = function()
        for key, info in pairs(pairs_config.keys) do
            vim.keymap.set("i", key, function()
                return (key == " " and "<C-]>" or "") .. handler(key, info, "insert")
            end, { noremap = true, expr = true })

            if
                not pairs_config.options.disable_command_mode
                and not info.disable_command_mode
            then
                vim.keymap.set("c", key, function()
                    return (key == " " and "<C-]>" or "")
                        .. handler(key, info, "command")
                end, { noremap = true, expr = true })
            end
        end
    end,
})

-- }}}
