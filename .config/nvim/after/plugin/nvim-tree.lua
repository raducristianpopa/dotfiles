local status, tree = pcall(require, "nvim-tree")
if (not status) then return end

local function custom_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "NVIMTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "o", api.tree.change_root_to_node, opts("CD"))
    vim.keymap.set("n", "<Tab>", "<nop>", opts("Do nothing"))
end

tree.setup({
    sort_by = "name",
    view = {
        width = 30,
        side = "right",
        number = true,
        relativenumber = true,
    },
    renderer = {
        group_empty = true,
    },
    on_attach = custom_on_attach,
})

vim.keymap.set("n", "<C-n>", vim.cmd.NvimTreeToggle)
