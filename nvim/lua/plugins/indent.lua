return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufEnter",
        opts = {
            indent = {
                char = "│",
                tab_char = "»",
            },
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "help",
                    "lazy",
                    "mason",
                    "notify",
                    "oil",
                },
            },
        },
        main = "ibl",
    },
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = "BufEnter",
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "lazy",
                    "mason",
                    "notify",
                    "oil",
                    "Oil",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    }
}
