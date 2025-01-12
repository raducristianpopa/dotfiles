return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        prettier = {
            config_command = "--config",
            config_names = {
                ".prettierrc",
                ".prettierrc.json",
                ".prettierrc.yml",
                ".prettierrc.yaml",
                ".prettierrc.json5",
                ".prettierrc.js",
                ".editorconfig",
            },
            config_path = ".prettierrc.json",
        },
        notify_on_error = false,
        default_format_opts = {
            async = true,
        },
        format_after_save = {},
        formatters_by_ft = {
            javascript = { "prettierd", "prettier" },
            typescript = { "prettierd", "prettier" },
            typescriptreact = { "prettierd", "prettier" },
            svelte = { "prettierd", "prettier" },
            astro = { "prettierd", "prettier" },
            gleam = { "gleam" },
            json = { "prettierd", "prettier" },
            lua = {},
            go = { "gofmt" },
        },
    },
    keys = {},
}
