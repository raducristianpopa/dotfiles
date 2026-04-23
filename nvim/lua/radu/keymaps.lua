local nnoremap = require("radu.utils").nnoremap
local vnoremap = require("radu.utils").vnoremap
local xnoremap = require("radu.utils").xnoremap
local inoremap = require("radu.utils").inoremap

local utils = require("radu.utils")
local diagnostics = require("radu.diagnostics")

local M = {}

-- Normal Mode --
vnoremap("<space>", "<nop>", { desc = "Disabled - leader key (visual mode)" })

-- Center buffer while navigating
nnoremap("<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
nnoremap("<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
nnoremap("{", "{zz", { desc = "Jump to previous paragraph and center" })
nnoremap("}", "}zz", { desc = "Jump to next paragraph and center" })
nnoremap("N", "Nzz", { desc = "Search previous and center" })
nnoremap("n", "nzz", { desc = "Search next and center" })
nnoremap("G", "Gzz", { desc = "Go to end of file and center" })
nnoremap("gg", "ggzz", { desc = "Go to beginning of file and center" })
nnoremap("gd", "gdzz", { desc = "Go to definition and center" })
nnoremap("<C-i>", "<C-i>zz", { desc = "Jump forward in jump list and center" })
nnoremap("<C-o>", "<C-o>zz", { desc = "Jump backward in jump list and center" })
nnoremap("%", "%zz", { desc = "Jump to matching bracket and center" })
nnoremap("*", "*zz", { desc = "Search for word under cursor and center" })
nnoremap("#", "#zz", { desc = "Search backward for word under cursor and center" })

-- Diagnostics --
nnoremap("]d", diagnostics.next_diagnostic, { desc = "Go to next error diagnostic and center" })
nnoremap("[d", diagnostics.previous_diagnostic, { desc = "Go to previous diagnostic and center" })
nnoremap("]e", diagnostics.next_error, { desc = "Go to next error diagnostic and center" })
nnoremap("[e", diagnostics.previous_error, { desc = "Go to previous error diagnostic and center" })
nnoremap("]w", diagnostics.next_warning, { desc = "Go to next warning diagnostic and center" })
nnoremap("[w", diagnostics.previous_warning, { desc = "Go to previous warning diagnostic and center" })
nnoremap("<leader>d", diagnostics.open_float, { desc = "Open diagnostic float with rounded border" })

-- Open link under cursor (supports markdown links and links in parens)
nnoremap("gx", utils.open_link, { silent = true, desc = "Open link under cursor (supports markdown and parens)" })

-- Quick find/replace for word under cursor
nnoremap("S", utils.find_and_replace_termcodes, { desc = "Quick find/replace word under cursor" })

-- Jump to start/end of line
nnoremap("H", "^", { desc = "Go to start of a line" })
nnoremap("L", "$", { desc = "Go to end of a line" })

-- Select everything in the current buffer
nnoremap("<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Replace current highlighted text under cursor
nnoremap("<leader>rh", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace highlighted text under cursor" })

-- Insert Mode
inoremap("jj", "<esc>", { desc = "Exit insert mode (jj)" })
inoremap("JJ", "<esc>", { desc = "Exit insert mode (JJ)" })

-- Visual Mode
vnoremap("J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines down" })
vnoremap("K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines up" })
xnoremap("<leader>p", "\"_dP", { desc = "Do not yank the selected chars/lines after pasting" })
xnoremap("<<", function () vim.cmd("normal! <<") vim.cmd("normal! gv")  end, { desc = "Indent left and reselect visual block" })
xnoremap(">>", function () vim.cmd("normal! >>") vim.cmd("normal! gv")  end, { desc = "Indent right and reselect visual block" })

-- Undotree
nnoremap("<leader>ut", "<Cmd>UndotreeToggle<CR>", { desc = "Open undo tree" })

-- Git Blame
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle current line blame (Gitsigns)" })

-- Oil
local function map_oil_keybinds(oil)
    nnoremap("<leader>pv", function() oil.toggle_float() end, { desc = "Open Oil" })
end

-- Spectre
local function map_spectre_keybinds(spectre)
    nnoremap("<leader>S", function() spectre.toggle() end, { desc = "Open Spectre for global find/replace" })
    nnoremap("<leader>sw", function() spectre.open_visual({ select_word = true }) end, { desc = "Search current word" })
end

-- LSP bindings
local function map_lsp_keybinds(buffer_number)
    local telescope_builtin = require("telescope.builtin");
    local signature_help = function() return vim.lsp.buf.signature_help({ border = "rounded" }) end
    local hover = function() return vim.lsp.buf.hover({ border = "rounded" }) end

    nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename symbol", buffer = buffer_number })
    nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action", buffer = buffer_number })
    nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition", buffer = buffer_number })
    nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: Go to declaration", buffer = buffer_number })
    nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: Type definition", buffer = buffer_number })
    nnoremap("gr", telescope_builtin.lsp_references, { desc = "LSP: Go to references", buffer = buffer_number })
    nnoremap("gi", telescope_builtin.lsp_implementations, { desc = "LSP: Go to implementations", buffer = buffer_number })
    nnoremap("<leader>bs", telescope_builtin.lsp_document_symbols, { desc = "LSP: Buffer Symbols", buffer = buffer_number })
    nnoremap("<leader>ps", telescope_builtin.lsp_workspace_symbols, { desc = "LSP: Project symbols", buffer = buffer_number })
    nnoremap("K", hover, { desc = "LSP: Signature documentation", buffer = buffer_number })
    inoremap("<C-h>", signature_help, { desc = "LSP: Signature documentation", buffer = buffer_number })
end

-- Harpoon bindings
local function map_harpoon_keybinds(harpoon)
    nnoremap("<leader>a", function() harpoon:list():add() end)
    nnoremap("<leader>h", function() harpoon.ui:toggle_quick_menu(require('harpoon'):list()) end)
    nnoremap("<leader>1", function() harpoon:list():select(1) end)
    nnoremap("<leader>2", function() harpoon:list():select(2) end)
    nnoremap("<leader>3", function() harpoon:list():select(3) end)
    nnoremap("<leader>4", function() harpoon:list():select(4) end)
    nnoremap("<leader>5", function() harpoon:list():select(4) end)
    nnoremap("<C-P>", function() harpoon:list():prev() end)
    nnoremap("<C-N>", function() harpoon:list():next() end)
end

M.map_lsp_keybinds = map_lsp_keybinds
M.map_harpoon_keybinds = map_harpoon_keybinds
M.map_spectre_keybinds = map_spectre_keybinds
M.map_oil_keybinds = map_oil_keybinds

return M
