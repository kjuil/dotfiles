vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    "https://github.com/nvim-treesitter/nvim-treesitter-context"
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        pcall(vim.treesitter.start, bufnr)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*" },
    callback = function()
        local ok = pcall(vim.treesitter.start)
        if not ok then
            return
        end
        vim.wo[0].foldmethod = "expr"
        vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.bo[0].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
