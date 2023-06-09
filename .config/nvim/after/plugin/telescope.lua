pcall(require("telescope").load_extension, "fzf")

local status, telescope_builtin = pcall(require, "telescope.builtin")
if (not status) then return end;

vim.keymap.set("n", "<leader>?", telescope_builtin.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", telescope_builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sf", telescope_builtin.find_files, { desc = "[S]earch [f]iles" })
vim.keymap.set("n", "<leader>sg", telescope_builtin.git_files, { desc = "[S]earch [g]it files" })
vim.keymap.set("n", "<leader>sr", telescope_builtin.live_grep, { desc = "[S]earch by [r]ipgrep" })
vim.keymap.set("n", "<leader>sw", function ()
    telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "[S]earch current [w]ord" })
vim.keymap.set("n", "<leader>/", function()
    telescope_builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = "[/] Fuzzily search in current buffer" })

