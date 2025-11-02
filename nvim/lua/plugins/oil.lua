vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
        vim.opt_local.colorcolumn = ""
    end,
})

return {
    {
        "stevearc/oil.nvim",
        opts = {},
        -- Optional dependencies
        dependencies = { "echasnovski/mini.icons", opts = {} },
        config = function()
            require("oil").setup({
                use_default_keymaps = false,
                confirmation = {
                    border = "rounded",
                },
                float = {
                    border = "rounded",
                },
                keymaps = {
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.select",
                    ["<C-\\>"] = "actions.select_split",
                    ["<C-enter>"] = "actions.select_vsplit", -- this is used to navigate left
                    ["<C-t>"] = "actions.select_tab",
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = "actions.close",
                    ["<C-r>"] = "actions.refresh",
                    ["-"] = "actions.parent",
                    ["_"] = "actions.open_cwd",
                    ["`"] = "actions.cd",
                    ["~"] = "actions.tcd",
                    ["gs"] = "actions.change_sort",
                    ["gx"] = "actions.open_external",
                    ["g."] = "actions.toggle_hidden",
                },
                view_options = {
                    show_hidden = true,
                },
                win_options = {
                    signcolumn = "auto:2",
                },
            })
        end,
    },
    {
        "refractalize/oil-git-status.nvim",
        dependencies = {
            "stevearc/oil.nvim",
        },
        config = function ()
            local oil_git_status = require("oil-git-status");
            oil_git_status.setup({
                show_ignored = false
            })
        end
    },
}
