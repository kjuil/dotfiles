require("nvim-tree").setup({
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    sort = { sorter = "case_sensitive", },
    view = { width = 30, preserve_window_proportions = true },
    renderer = {
        group_empty = true,
        highlight_git = "name",
        indent_markers = { enable = true },
        icons = { git_placement = "after" }
    },
    git = { enable = true },
    diagnostics = { enable = true },
    modified = { enable = true },
    filters = {
        enable = true,
        dotfiles = true,
        git_ignored = false
    },
})

vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { desc = "Explore" })
