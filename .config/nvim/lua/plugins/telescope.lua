return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build =
            "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            cond = vim.fn.executable("cmake") == 1,
        },
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin");
        local nnoremap = require("radu.utils").nnoremap

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-x>"] = actions.delete_buffer,
                    },
                },
                file_ignore_patterns = {
                    "node_modules",
                    "yarn.lock",
                    ".git",
                    ".sl",
                    "_build",
                    ".next",
                },
                hidden = true,
            },
        })

        nnoremap("<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
        nnoremap("<leader>sb", builtin.buffers, { desc = "[S]earch Open [B]uffers" })
        nnoremap("<leader>sf", builtin.find_files, { desc = "[S]earch [f]iles" })
        nnoremap("<leader>sg", builtin.git_files, { desc = "[S]earch [g]it files" })
        nnoremap("<leader>sr", builtin.live_grep, { desc = "[S]earch by [r]ipgrep" })
        nnoremap("<leader>sw", function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end,
            { desc = "[S]earch current [w]ord" })
        nnoremap("<leader>/", function()
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = "[/] Fuzzily search in current buffer" })

        -- Enable telescope fzf native, if installed
        pcall(telescope.load_extension, "fzf")
    end,
}
