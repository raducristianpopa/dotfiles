local nnoremap = require("radu.utils").nnoremap
local vnoremap = require("radu.utils").vnoremap
local xnoremap = require("radu.utils").xnoremap

---[[ NORMAL ]]---
nnoremap("<space>", "<nop>", { desc = "Disabled - leader key (normal mode)" })
nnoremap("H", "^", { desc = "Go to start of a line" })
nnoremap("L", "$", { desc = "Go to end of a line" })
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle current line blame (Gitsigns)" })
nnoremap("<leader>pv", function() require("oil").toggle_float() end, { desc = "Open Oil" })
nnoremap("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace highlighted" })
nnoremap("<leader>w", "<Cmd>write<CR>", { desc = "[W]rite" })
nnoremap("<leader>z", "<Cmd>wq<CR>", { desc = "Save and Quit ", silent = false })
nnoremap("<C-a>", "gg<S-v>G", { desc = "Select all" })
nnoremap("]d", function() vim.diagnostic.goto_next({ float = true }) end, { desc = "Go to next diagnostic message (all severities)" })
nnoremap("[d", function() vim.diagnostic.goto_prev({ float = true }) end, { desc = "Go to next diagnostic message (all severities)" })
nnoremap("]e", function() vim.diagnostic.goto_next({ float = true, severity = vim.diagnostic.severity.E }) end, { desc = "Go to next diagnostic error" })
nnoremap("[e", function() vim.diagnostic.goto_prev({ float = true, severity = vim.diagnostic.severity.E }) end, { desc = "Go to previous diagnostic error" })
nnoremap("]w", function() vim.diagnostic.goto_next({ float = true, severity = vim.diagnostic.severity.W }) end, { desc = "Go to next diagnostic warning" })
nnoremap("[w", function() vim.diagnostic.goto_prev({ float = true, severity = vim.diagnostic.severity.W }) end, { desc = "Go to previous diagnostic warning" })
nnoremap("<leader>S", function() require("spectre").toggle() end, { desc = "Open Spectre for global find/replace" })
nnoremap("<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, { desc = "Search current word" })
nnoremap("<leader>ut", "<Cmd>UndotreeToggle<CR>", { desc = "Open undo tree" })

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

---[[ VISUAL & SELECT ]]---
vnoremap("<space>", "<nop>", { desc = "Disabled - leader key (visual mode)" })
vnoremap("J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines down" })
vnoremap("K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines up" })

xnoremap("<leader>p", "\"_dP", { desc = "Do not yank the selected chars/lines after pasting" })
