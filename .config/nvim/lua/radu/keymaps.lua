local nnoremap = require("radu.utils").nnoremap
local vnoremap = require("radu.utils").vnoremap
local xnoremap = require("radu.utils").xnoremap
local inoremap = require("radu.utils").inoremap

local M = {}

--[[ NORMAL ]]--
nnoremap("<space>", "<nop>", { desc = "Disabled - leader key (normal mode)" })
nnoremap("H", "^", { desc = "Go to start of a line" })
nnoremap("L", "$", { desc = "Go to end of a line" })
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle current line blame (Gitsigns)" })
nnoremap("<leader>pv", vim.cmd.Ex, { desc = "Go back to NetRW" })
nnoremap("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace highlighted" })
nnoremap("<leader>w", "<Cmd>write<CR>", { desc = "[W]rite" })
nnoremap("<leader>z", "<Cmd>wq<CR>", { desc = "Save and Quit ", silent = false })
nnoremap("<C-a>", "gg<S-v>G", { desc = "Select all" })
nnoremap("]d", function() vim.diagnostic.goto_next() end, { desc = "Go to next diagnostic message" })
nnoremap("[d", function() vim.diagnostic.goto_prev() end, { desc = "Go to previous diagnostic message" })

-- Center buffer while navigating
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("{", "{zz")
nnoremap("}", "}zz")
nnoremap("N", "Nzz")
nnoremap("n", "nzz")
nnoremap("G", "Gzz")
nnoremap("gg", "ggzz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("<C-o>", "<C-o>zz")
nnoremap("%", "%zz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")

--[[ VISUAL & SELECT ]]--

vnoremap("<space>", "<nop>", { desc = "Disabled - leader key (visual mode)" })
vnoremap("J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines down" })
vnoremap("K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines up" })

xnoremap("<leader>p", "\"_dP", { desc = "Do not yank the selected chars/lines after pasting" })

--[[ PLUGINS ]]--
-- Telescope

local telescope_builtin = require("telescope.builtin")

nnoremap("<leader>?", telescope_builtin.oldfiles, { desc = "[?] Find recently opened files" })
nnoremap("<leader>sb", telescope_builtin.buffers, { desc = "[S]earch Open [B]uffers" })
nnoremap("<leader>sf", telescope_builtin.find_files, { desc = "[S]earch [f]iles" })
nnoremap("<leader>sg", telescope_builtin.git_files, { desc = "[S]earch [g]it files" })
nnoremap("<leader>sr", telescope_builtin.live_grep, { desc = "[S]earch by [r]ipgrep" })
nnoremap("<leader>sw", function ()
    telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "[S]earch current [w]ord" })
nnoremap("<leader>/", function()
    telescope_builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = "[/] Fuzzily search in current buffer" })

M.map_lsp_keybinds = function(buffer_number)
	nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
	nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })
	nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })
	nnoremap(
		"gr",
		require("telescope.builtin").lsp_references,
		{ desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
	)
	nnoremap(
		"gi",
		require("telescope.builtin").lsp_implementations,
		{ desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
	)
	nnoremap(
		"<leader>bs",
		require("telescope.builtin").lsp_document_symbols,
		{ desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number }
	)
	nnoremap(
		"<leader>ps",
		require("telescope.builtin").lsp_workspace_symbols,
		{ desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number }
	)
	nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
	inoremap("<C-h>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
	nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
	nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end

return M
