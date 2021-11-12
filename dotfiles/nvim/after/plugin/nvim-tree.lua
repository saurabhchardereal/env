-- Enable highligting for folders and both file icons and names
vim.g.nvim_tree_highlight_opened_files = 3

-- Main setup
require'nvim-tree'.setup {
    auto_close = true,
    disable_netrw = false,
    diagnostics = {
        enable = true,
    },
    -- Do not show hidden files by default (can be toggled by `H`)
    filters = {
        dotfiles = true,
    },
    view = {
        auto_resize = true,
    },
}

-- Mappings
vim.api.nvim_set_keymap('n', '<F1>', ':NvimTreeToggle<CR>', {
    noremap = true,
    silent = true
})

vim.api.nvim_set_keymap('n', '<Leader><F1>', ':NvimTreeFindFile<CR>', {
    noremap = true,
    silent = true
})