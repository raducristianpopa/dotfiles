local nnoremap = require("radu.utils").nnoremap
local vnoremap = require("radu.utils").vnoremap
local xnoremap = require("radu.utils").xnoremap

---[[ NORMAL ]]---
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

---[[ VISUAL & SELECT ]]---
vnoremap("<space>", "<nop>", { desc = "Disabled - leader key (visual mode)" })
vnoremap("J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines down" })
vnoremap("K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines up" })

xnoremap("<leader>p", "\"_dP", { desc = "Do not yank the selected chars/lines after pasting" })
