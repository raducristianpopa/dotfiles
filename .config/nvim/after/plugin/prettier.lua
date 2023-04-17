local status, prettier = pcall(require, "prettier")
if (not status) then return end

prettier.setup({
    bin = "prettier",
    cli_options = {
        arrow_parens = "always",
        embedded_language_formatting = "auto",
        end_of_line = "lf",
        jsx_single_quote = false,
        print_width = 80,
        semi = true,
        single_attribute_per_line = false,
        single_quote = false,
        tab_width = 4,
        trailing_comma = "all",
        use_tabs = "false",
    },
    filetypes = {
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
    }
})
