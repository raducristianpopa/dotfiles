local map = vim.keymap.set
vim.g.mapleader = " "

map("n", "<leader>w", "<Cmd>write | Prettier<CR>", { desc = "[W]rite current file and run Prettier" })
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Go back to NetRW" })
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace highlighted" })
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })
map("n", "<leader>ta", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "[T]ab [C]lose" })
map("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "[T]ab [O]nly - close all tabs except the current one" })
map("n", "<Tab>", "<cmd>tabnext<CR>", { desc = "Cycle to next tab" })
map("n", "<S-Tab>", "<cmd>tabprev<CR>", { desc = "Cycle to previous tab" })
--map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "[T]ab [N]ext" })
--map("n", "<leader>tp", "<cmd>tabprev<CR>", { desc = "[T]ab [P]revious" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines up" })

-- Better search navigation
map("n", "n", "nzzzv");
map("n", "N", "Nzzzv");

-- Do not yank the selected chars/lines after pasting
map("x", "<leader>p", "\"_dP")
