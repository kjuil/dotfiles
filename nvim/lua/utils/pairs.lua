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
        touch_regex = "[%w(%[{]",
        pair_spaces = false,
        auto_indent = true,
        disable_command_mode = false,
    },
    disabled = false,
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
    if config.disabled then
        return key
    end

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
