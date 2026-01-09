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
vim.o.cursorlineopt = "number"
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "120"
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.cmdheight = 1
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "UTF-8"
vim.o.wildmenu = true
vim.o.pumheight = 10
vim.o.completeopt = "menu,menuone,noselect,popup,fuzzy"
vim.o.mouse = "a"
vim.o.confirm = true
vim.o.autoread = true
vim.o.breakindent = true
vim.o.updatetime = 200
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.inccommand = "split"
vim.o.winborder = "rounded"
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

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

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

if vim.g.neovide then
    vim.o.guifont = "JetbrainsMono Nerd Font:h12"
    local bg = vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).bg
    local fg = vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).fg
    vim.g.neovide_title_background_color = string.format("%x", bg)
    vim.g.neovide_title_text_color = string.format("%x", fg)
    vim.g.neovide_hide_mouse_when_typing = true
end
