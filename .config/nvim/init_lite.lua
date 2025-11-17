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
vim.o.signcolumn = "auto"
vim.o.colorcolumn = "100"
vim.o.showmode = false
vim.o.showcmd = true
vim.o.termguicolors = true
vim.o.cmdheight = 1
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "UTF-8"
vim.o.wildmenu = true
vim.o.pumheight = 10
vim.o.completeopt = "menuone,noselect,popup,fuzzy"
vim.o.mouse = "a"
vim.o.confirm = true
vim.o.autoread = true
vim.o.breakindent = true
vim.o.updatetime = 200
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)
vim.o.inccommand = "split"
vim.o.winborder = "rounded"

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
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight Copying Text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 500 })
    end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    desc = "Format On Save",
    pattern = '*',
    callback = function()
        vim.lsp.buf.format()
    end,
})

---}}}

-- Lspconfig {{{
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
        basedpyright = {
            analysis = { typeCheckingMode = "off" },
        },
    },
})

vim.lsp.config("marksman", {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "markdown.mdx" },
    root_markers = { ".marksman.toml", ".git" },
    single_file_support = true,
})

vim.lsp.enable({ "lua_ls", "clangd", "basedpyright" })

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
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
        vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Lsp Format" })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method "textDocument/foldingRange" then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set("n", "<leader>ih", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { buffer = event.buf, desc = "Inlay Hints" })
        end
    end,
})

-- }}}

-- Colorscheme {{{
local c = {
    black = "#0e1013",
    bg0 = "#1f2329",
    bg1 = "#282c34",
    bg2 = "#30363f",
    bg3 = "#323641",
    bg_d = "#181b20",
    bg_blue = "#61afef",
    bg_yellow = "#e8c88c",
    fg = "#a0a8b7",
    purple = "#bf68d9",
    green = "#8ebd6b",
    orange = "#cc9057",
    blue = "#4fa6ed",
    yellow = "#e2b86b",
    cyan = "#48b0bd",
    red = "#e55561",
    grey = "#535965",
    light_grey = "#7a818e",
    diff_add = "#272e23",
    diff_delete = "#2d2223",
    diff_change = "#172a3a",
    diff_text = "#274964",
    none = "NONE",
}

local cfg = {
    transparent = false,
    ending_tildes = false,
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },
}

local highlights = {
    Normal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
    Terminal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
    EndOfBuffer = { fg = cfg.ending_tildes and c.bg2 or c.bg0, bg = cfg.transparent and c.none or c.bg0 },
    FoldColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
    Folded = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
    SignColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
    ToolbarLine = { fg = c.fg },
    Cursor = { fmt = "reverse" },
    vCursor = { fmt = "reverse" },
    iCursor = { fmt = "reverse" },
    lCursor = { fmt = "reverse" },
    CursorIM = { fmt = "reverse" },
    CursorColumn = { bg = c.bg1 },
    CursorLine = { bg = c.bg1 },
    ColorColumn = { bg = c.bg1 },
    CursorLineNr = { fg = c.fg },
    LineNr = { fg = c.grey },
    Conceal = { fg = c.grey, bg = c.bg1 },
    Added = { fg = c.green },
    Removed = { fg = c.red },
    Changed = { fg = c.blue },
    DiffAdd = { fg = c.none, bg = c.diff_add },
    DiffChange = { fg = c.none, bg = c.diff_change },
    DiffDelete = { fg = c.none, bg = c.diff_delete },
    DiffText = { fg = c.none, bg = c.diff_text },
    DiffAdded = { fg = c.green },
    DiffChanged = { fg = c.blue },
    DiffRemoved = { fg = c.red },
    DiffDeleted = { fg = c.red },
    DiffFile = { fg = c.cyan },
    DiffIndexLine = { fg = c.grey },
    Directory = { fg = c.blue },
    ErrorMsg = { fg = c.red, fmt = "bold" },
    WarningMsg = { fg = c.yellow, fmt = "bold" },
    MoreMsg = { fg = c.blue, fmt = "bold" },
    CurSearch = { fg = c.bg0, bg = c.orange },
    IncSearch = { fg = c.bg0, bg = c.orange },
    Search = { fg = c.bg0, bg = c.bg_yellow },
    Substitute = { fg = c.bg0, bg = c.green },
    MatchParen = { fg = c.none, bg = c.grey },
    NonText = { fg = c.grey },
    Whitespace = { fg = c.grey },
    SpecialKey = { fg = c.grey },
    Pmenu = { fg = c.fg, bg = c.bg1 },
    PmenuSbar = { fg = c.none, bg = c.bg1 },
    PmenuSel = { fg = c.bg0, bg = c.bg_blue },
    WildMenu = { fg = c.bg0, bg = c.blue },
    PmenuThumb = { fg = c.none, bg = c.grey },
    Question = { fg = c.yellow },
    SpellBad = { fg = c.none, fmt = "undercurl", sp = c.red },
    SpellCap = { fg = c.none, fmt = "undercurl", sp = c.yellow },
    SpellLocal = { fg = c.none, fmt = "undercurl", sp = c.blue },
    SpellRare = { fg = c.none, fmt = "undercurl", sp = c.purple },
    StatusLine = { fg = c.fg, bg = cfg.transparent and c.none or c.bg2 },
    StatusLineTerm = { fg = c.fg, bg = cfg.transparent and c.none or c.bg2 },
    StatusLineNC = { fg = c.grey, bg = cfg.transparent and c.none or c.bg1 },
    StatusLineTermNC = { fg = c.grey, bg = cfg.transparent and c.none or c.bg1 },
    TabLine = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
    TabLineFill = { fg = c.grey, bg = cfg.transparent and c.none or c.bg1 },
    TabLineSel = { fg = c.bg0, bg = cfg.transparent and c.none or c.fg },
    WinSeparator = { fg = c.bg3 },
    Visual = { bg = c.bg3 },
    VisualNOS = { fg = c.none, bg = c.bg2, fmt = "underline" },
    QuickFixLine = { fg = c.blue, fmt = "underline" },
    Debug = { fg = c.yellow },
    debugPC = { fg = c.bg0, bg = c.green },
    debugBreakpoint = { fg = c.bg0, bg = c.red },
    ToolbarButton = { fg = c.bg0, bg = c.bg_blue },
    FloatBorder = { fg = c.grey, bg = cfg.transparent and c.none or c.bg1 },
    NormalFloat = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },

    ModeNormal = { fg = c.green, gui = "bold" },
    ModeInsert = { fg = c.blue, gui = "bold" },
    ModeCommand = { fg = c.yellow, gui = "bold" },
    ModeVisual = { fg = c.purple, gui = "bold" },
    ModeReplace = { fg = c.red, gui = "bold" },
    ModeTerminal = { fg = c.cyan, gui = "bold" },

    LspDiagnosticsSignError = { fg = c.red },
    LspDiagnosticsSignWarning = { fg = c.yellow },
    LspDiagnosticsSignHint = { fg = c.blue },
    LspDiagnosticsSignInformation = { fg = c.green },

    -- syntax
    String = { fg = c.green, fmt = cfg.code_style.strings },
    Character = { fg = c.orange },
    Number = { fg = c.orange },
    Float = { fg = c.orange },
    Boolean = { fg = c.orange },
    Type = { fg = c.yellow },
    Structure = { fg = c.yellow },
    StorageClass = { fg = c.yellow },
    Identifier = { fg = c.red, fmt = cfg.code_style.variables },
    Constant = { fg = c.cyan },
    PreProc = { fg = c.purple },
    PreCondit = { fg = c.purple },
    Include = { fg = c.purple },
    Keyword = { fg = c.purple, fmt = cfg.code_style.keywords },
    Define = { fg = c.purple },
    Typedef = { fg = c.yellow },
    Exception = { fg = c.purple },
    Conditional = { fg = c.purple, fmt = cfg.code_style.keywords },
    Repeat = { fg = c.purple, fmt = cfg.code_style.keywords },
    Statement = { fg = c.purple },
    Macro = { fg = c.red },
    Error = { fg = c.purple },
    Label = { fg = c.purple },
    Special = { fg = c.red },
    SpecialChar = { fg = c.red },
    Function = { fg = c.blue, fmt = cfg.code_style.functions },
    Operator = { fg = c.purple },
    Title = { fg = c.cyan },
    Tag = { fg = c.green },
    Delimiter = { fg = c.light_grey },
    Comment = { fg = c.grey, fmt = cfg.code_style.comments },
    SpecialComment = { fg = c.grey, fmt = cfg.code_style.comments },
    Todo = { fg = c.red, fmt = cfg.code_style.comments },

    -- treesitter
    ["@annotation"] = { fg = c.fg },
    ["@attribute"] = { fg = c.cyan },
    ["@attribute.typescript"] = { fg = c.blue },
    ["@boolean"] = { fg = c.orange },
    ["@character"] = { fg = c.orange },
    ["@comment"] = { fg = c.grey, fmt = cfg.code_style.comments },
    ["@comment.todo"] = { fg = c.red, fmt = cfg.code_style.comments },
    ["@comment.todo.unchecked"] = { fg = c.red, fmt = cfg.code_style.comments },
    ["@comment.todo.checked"] = { fg = c.green, fmt = cfg.code_style.comments },
    ["@constant"] = { fg = c.orange, fmt = cfg.code_style.constants },
    ["@constant.builtin"] = { fg = c.orange, fmt = cfg.code_style.constants },
    ["@constant.macro"] = { fg = c.orange, fmt = cfg.code_style.constants },
    ["@constructor"] = { fg = c.yellow, fmt = "bold" },
    ["@diff.add"] = { fg = c.green },
    ["@diff.delete"] = { fg = c.red },
    ["@diff.plus"] = { fg = c.green },
    ["@diff.minus"] = { fg = c.red },
    ["@diff.delta"] = { fg = c.blue },
    ["@error"] = { fg = c.fg },
    ["@function"] = { fg = c.blue, fmt = cfg.code_style.functions },
    ["@function.builtin"] = { fg = c.cyan, fmt = cfg.code_style.functions },
    ["@function.macro"] = { fg = c.cyan, fmt = cfg.code_style.functions },
    ["@function.method"] = { fg = c.blue, fmt = cfg.code_style.functions },
    ["@keyword"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.conditional"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.directive"] = { fg = c.purple },
    ["@keyword.exception"] = { fg = c.purple },
    ["@keyword.function"] = { fg = c.purple, fmt = cfg.code_style.functions },
    ["@keyword.import"] = { fg = c.purple },
    ["@keyword.operator"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@keyword.repeat"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@label"] = { fg = c.red },
    ["@markup.emphasis"] = { fg = c.fg, fmt = 'italic' },
    ["@markup.environment"] = { fg = c.fg },
    ["@markup.environment.name"] = { fg = c.fg },
    ["@markup.heading"] = { fg = c.orange, fmt = 'bold' },
    ["@markup.link"] = { fg = c.blue },
    ["@markup.link.url"] = { fg = c.cyan, fmt = 'underline' },
    ["@markup.list"] = { fg = c.red },
    ["@markup.math"] = { fg = c.fg },
    ["@markup.raw"] = { fg = c.green },
    ["@markup.strike"] = { fg = c.fg, fmt = 'strikethrough' },
    ["@markup.strong"] = { fg = c.fg, fmt = 'bold' },
    ["@markup.underline"] = { fg = c.fg, fmt = 'underline' },
    ["@module"] = { fg = c.yellow },
    ["@none"] = { fg = c.fg },
    ["@number"] = { fg = c.orange },
    ["@number.float"] = { fg = c.orange },
    ["@operator"] = { fg = c.fg },
    ["@parameter.reference"] = { fg = c.fg },
    ["@property"] = { fg = c.cyan },
    ["@punctuation.delimiter"] = { fg = c.light_grey },
    ["@punctuation.bracket"] = { fg = c.light_grey },
    ["@string"] = { fg = c.green, fmt = cfg.code_style.strings },
    ["@string.regexp"] = { fg = c.orange, fmt = cfg.code_style.strings },
    ["@string.escape"] = { fg = c.red, fmt = cfg.code_style.strings },
    ["@string.special.symbol"] = { fg = c.cyan },
    ["@tag"] = { fg = c.purple },
    ["@tag.attribute"] = { fg = c.yellow },
    ["@tag.delimiter"] = { fg = c.purple },
    ["@text"] = { fg = c.fg },
    ["@note"] = { fg = c.fg },
    ["@warning"] = { fg = c.fg },
    ["@danger"] = { fg = c.fg },
    ["@type"] = { fg = c.yellow },
    ["@type.builtin"] = { fg = c.orange },
    ["@variable"] = { fg = c.fg, fmt = cfg.code_style.variables },
    ["@variable.builtin"] = { fg = c.red, fmt = cfg.code_style.variables },
    ["@variable.member"] = { fg = c.cyan },
    ["@variable.parameter"] = { fg = c.red },
    ["@markup.heading.1.markdown"] = { fg = c.red, fmt = "bold" },
    ["@markup.heading.2.markdown"] = { fg = c.purple, fmt = "bold" },
    ["@markup.heading.3.markdown"] = { fg = c.orange, fmt = "bold" },
    ["@markup.heading.4.markdown"] = { fg = c.red, fmt = "bold" },
    ["@markup.heading.5.markdown"] = { fg = c.purple, fmt = "bold" },
    ["@markup.heading.6.markdown"] = { fg = c.orange, fmt = "bold" },
    ["@markup.heading.1.marker.markdown"] = { fg = c.red, fmt = "bold" },
    ["@markup.heading.2.marker.markdown"] = { fg = c.purple, fmt = "bold" },
    ["@markup.heading.3.marker.markdown"] = { fg = c.orange, fmt = "bold" },
    ["@markup.heading.4.marker.markdown"] = { fg = c.red, fmt = "bold" },
    ["@markup.heading.5.marker.markdown"] = { fg = c.purple, fmt = "bold" },
    ["@markup.heading.6.marker.markdown"] = { fg = c.orange, fmt = "bold" },
    ["@conditional"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@exception"] = { fg = c.purple },
    ["@field"] = { fg = c.cyan },
    ["@float"] = { fg = c.orange },
    ["@include"] = { fg = c.purple },
    ["@method"] = { fg = c.blue, fmt = cfg.code_style.functions },
    ["@namespace"] = { fg = c.yellow },
    ["@parameter"] = { fg = c.red },
    ["@preproc"] = { fg = c.purple },
    ["@punctuation.special"] = { fg = c.red },
    ["@repeat"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@string.regex"] = { fg = c.orange, fmt = cfg.code_style.strings },
    ["@text.strong"] = { fg = c.fg, fmt = 'bold' },
    ["@text.emphasis"] = { fg = c.fg, fmt = 'italic' },
    ["@text.underline"] = { fg = c.fg, fmt = 'underline' },
    ["@text.strike"] = { fg = c.fg, fmt = 'strikethrough' },
    ["@text.title"] = { fg = c.orange, fmt = 'bold' },
    ["@text.literal"] = { fg = c.green },
    ["@text.uri"] = { fg = c.cyan, fmt = 'underline' },
    ["@text.todo"] = { fg = c.red, fmt = cfg.code_style.comments },
    ["@text.todo.unchecked"] = { fg = c.red, fmt = cfg.code_style.comments },
    ["@text.todo.checked"] = { fg = c.green, fmt = cfg.code_style.comments },
    ["@text.math"] = { fg = c.fg },
    ["@text.reference"] = { fg = c.blue },
    ["@text.environment"] = { fg = c.fg },
    ["@text.environment.name"] = { fg = c.fg },
    ["@text.diff.add"] = { fg = c.green },
    ["@text.diff.delete"] = { fg = c.red },

    -- lsp
    ["@lsp.type.comment"] = { fg = c.grey, fmt = cfg.code_style.comments },
    ["@lsp.type.enum"] = { fg = c.yellow },
    ["@lsp.type.enumMember"] = { fg = c.orange, fmt = cfg.code_style.constants },
    ["@lsp.type.interface"] = { fg = c.yellow },
    ["@lsp.type.typeParameter"] = { fg = c.yellow },
    ["@lsp.type.keyword"] = { fg = c.purple, fmt = cfg.code_style.keywords },
    ["@lsp.type.namespace"] = { fg = c.yellow },
    ["@lsp.type.parameter"] = { fg = c.red },
    ["@lsp.type.property"] = { fg = c.cyan },
    ["@lsp.type.variable"] = { fg = c.fg, fmt = cfg.code_style.variables },
    ["@lsp.type.macro"] = { fg = c.cyan, fmt = cfg.code_style.functions },
    ["@lsp.type.method"] = { fg = c.blue, fmt = cfg.code_style.functions },
    ["@lsp.type.number"] = { fg = c.orange },
    ["@lsp.type.generic"] = { fg = c.fg },
    ["@lsp.type.builtinType"] = { fg = c.orange },
    ["@lsp.typemod.method.defaultLibrary"] = { fg = c.blue, fmt = cfg.code_style.functions },
    ["@lsp.typemod.function.defaultLibrary"] = { fg = c.blue, fmt = cfg.code_style.functions },
    ["@lsp.typemod.operator.injected"] = { fg = c.fg },
    ["@lsp.typemod.string.injected"] = { fg = c.green, fmt = cfg.code_style.strings },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = c.red, fmt = cfg.code_style.variables },
    ["@lsp.typemod.variable.injected"] = { fg = c.fg, fmt = cfg.code_style.variables },
    ["@lsp.typemod.variable.static"] = { fg = c.orange, fmt = cfg.code_style.constants },
}

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.cmd("hi clear")
        if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
        for group, settings in pairs(highlights) do
            vim.api.nvim_command(string.format("highlight %s guifg=%s guibg=%s guisp=%s gui=%s", group,
                settings.fg or "none",
                settings.bg or "none",
                settings.sp or "none",
                settings.fmt or "none"))
        end
    end,
})

-- }}}

-- Statusline {{{
local function modes()
    local modes_map = {
        ["n"]     = { text = "NORMAL", color = "ModeNormal" },
        ["no"]    = { text = "O-PENDING", color = "ModeNormal" },
        ["nov"]   = { text = "O-PENDING", color = "ModeNormal" },
        ["noV"]   = { text = "O-PENDING", color = "ModeNormal" },
        ["no\22"] = { text = "O-PENDING", color = "ModeNormal" },
        ["niI"]   = { text = "NORMAL", color = "ModeNormal" },
        ["niR"]   = { text = "NORMAL", color = "ModeNormal" },
        ["niV"]   = { text = "NORMAL", color = "ModeNormal" },
        ["nt"]    = { text = "NORMAL", color = "ModeNormal" },
        ["ntT"]   = { text = "NORMAL", color = "ModeNormal" },
        ["v"]     = { text = "VISUAL", color = "ModeVisual" },
        ["vs"]    = { text = "VISUAL", color = "ModeVisual" },
        ["V"]     = { text = "V-LINE", color = "ModeVLine" },
        ["Vs"]    = { text = "V-LINE", color = "ModeVLine" },
        ["\22"]   = { text = "V-BLOCK", color = "ModeVBlock" },
        ["\22s"]  = { text = "V-BLOCK", color = "ModeVBlock" },
        ["s"]     = { text = "SELECT", color = "ModeSelect" },
        ["S"]     = { text = "S-LINE", color = "ModeSelect" },
        ["\19"]   = { text = "S-BLOCK", color = "ModeSelect" },
        ["i"]     = { text = "INSERT", color = "ModeInsert" },
        ["ic"]    = { text = "INSERT", color = "ModeInsert" },
        ["ix"]    = { text = "INSERT", color = "ModeInsert" },
        ["R"]     = { text = "REPLACE", color = "ModeReplace" },
        ["Rc"]    = { text = "REPLACE", color = "ModeReplace" },
        ["Rx"]    = { text = "REPLACE", color = "ModeReplace" },
        ["Rv"]    = { text = "V-REPLACE", color = "ModeReplace" },
        ["Rvc"]   = { text = "V-REPLACE", color = "ModeReplace" },
        ["Rvx"]   = { text = "V-REPLACE", color = "ModeReplace" },
        ["c"]     = { text = "COMMAND", color = "ModeCommand" },
        ["cv"]    = { text = "EX", color = "ModeCommand" },
        ["ce"]    = { text = "EX", color = "ModeCommand" },
        ["r"]     = { text = "REPLACE", color = "ModeReplace" },
        ["rm"]    = { text = "MORE", color = "ModeCommand" },
        ["r?"]    = { text = "CONFIRM", color = "ModeCommand" },
        ["!"]     = { text = "SHELL", color = "ModeCommand" },
        ["t"]     = { text = "TERMINAL", color = "ModeTerminal" },
    }
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_info = modes_map[current_mode] or modes_map[string.sub(current_mode, 1, 1)] or "UNK"
    return "%#" .. mode_info.color .. "# --" .. mode_info.text .. "-- %#StatusLine#"
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

    return " " .. errors .. warnings .. hints .. info .. "%#StatusLine# "
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
    local tabline_left = "%#TabLineFill#┃"
    local tabline_right = ""

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
            local edited = vim.bo.modified and "*" or " "
            local f_name = vim.api.nvim_buf_get_name(buf):match("^.+[\\/](.+)$") or "[No Name]"
            local padding = (20 - #f_name) / 2
            local padded_text = string.rep(" ", padding > 0 and padding or 0)

            local s = vim.api.nvim_get_current_buf() == buf
            tabline_left = tabline_left ..
                "%#TabLine" .. (s and "#" or "Fill#") ..
                " %" .. buf .. "@v:lua.PickBuffer@" ..
                padded_text .. f_name .. (s and edited or " ") .. padded_text ..
                "%#TabLineFill#┃"
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
vim.g.netrw_altv = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_sort_by = "exten"

vim.keymap.set("n", "<leader>e", "<CMD>Vexplore<CR>", { desc = "Netrw" })

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("netrw", { clear = true }),
    pattern = "netrw",
    callback = function()
        vim.opt_local.statusline = "  Netrw"
        vim.keymap.set("n", "<leader>e", "<CMD>bdelete<CR>", { buffer = true })
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
local window_config = {
    relative = "editor",
    row = 3,
    col = 10,
    height = vim.o.lines - 10,
    width = vim.o.columns - 20,
    border = "rounded",
    title = "Terminal",
    title_pos = "left",
    style = "minimal",
}

local function create_term()
    local spawn_terminal = false
    if buffer == nil then
        buffer = vim.api.nvim_create_buf(false, true)
        spawn_terminal = true
    end

    window = vim.api.nvim_open_win(buffer, true, window_config)

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
local config = {
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

    for _, info in pairs(config.keys) do
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
        return "<CR><ESC>O" .. (config.options.auto_indent and "" or "<C-D>")
    elseif info.escape and pair:sub(2, 2) == key then
        return mode == "insert" and "<C-G>U<Right>" or "<Right>"
    elseif info.close then
        -- don't pair spaces
        if
            key == " "
            and (
                not config.options.pair_spaces
                or (config.options.pair_spaces and not is_pair(pair))
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
        for key, info in pairs(config.keys) do
            vim.keymap.set("i", key, function()
                return (key == " " and "<C-]>" or "") .. handler(key, info, "insert")
            end, { noremap = true, expr = true })

            if
                not config.options.disable_command_mode
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

-- {{{

-- }}}
