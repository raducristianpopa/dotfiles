return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        local ts = require("nvim-treesitter.configs")
        ts.setup({
            ensure_installed = {
                "bash",
                "c",
                "markdown",
                "markdown_inline",
                "yaml",
                "json",
                "toml",
                "html",
                "svelte",
                "javascript",
                "typescript",
                "tsx",
                "rust",
                "php",
                "lua",
                "vim",
                "vimdoc",
                "gleam",
                "hcl",
                "helm"
            },
            modules = {},
            ignore_install = {},
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        })
    end
}
