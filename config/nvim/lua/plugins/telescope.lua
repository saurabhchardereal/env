return {
  "nvim-telescope/telescope.nvim",
  event = "BufEnter",
  dependencies = {
    "plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    local nnoremap = require("core.utils").mapper_factory("n")
    local builtin = require("telescope.builtin")

    -- Mappings
    nnoremap("<Leader>fv", builtin.find_files, { desc = "Find Files" })
    nnoremap("<Leader>dv", function()
      builtin.find_files({ cwd = "$CONFIG_DIR" })
    end, { desc = "Find Files in $CONFIG_DIR" })
    nnoremap("<Leader>hv", function()
      builtin.find_files({ cwd = "$HOME" })
    end, { desc = "Find Files in $HOME" })
    nnoremap("<Leader>bb", builtin.buffers, { desc = "Buffers List" })

    nnoremap(
      "<Leader>sb",
      builtin.current_buffer_fuzzy_find,
      { desc = "Live fuzzy search inside current buffer" }
    )

    nnoremap("<Leader>sg", builtin.live_grep, { desc = "Live Grep" })
    nnoremap("<Leader>st", builtin.help_tags, { desc = "Helptags" })
    nnoremap("<Leader>ss", builtin.builtin, { desc = "Telescope Builtins" })
    nnoremap("<Leader>sr", builtin.oldfiles, { desc = "Oldfiles" })

    -- Telescope base config
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          ".*/doc/.*.txt", -- ignores all doc files from pickers
          ".*/COMMIT_EDITMSG", -- ignore git commit msgs
        },
      },
    })

    -- Load native fzf sorter
    require("telescope").load_extension("fzf")
  end,
}