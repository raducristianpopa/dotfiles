local status, ncf = pcall(require, "no-clown-fiesta")
if (not status) then return end

-- Default options
ncf.setup({
    transparent = false, -- Enable this to disable the bg color
    styles = {
        -- You can set any of the style values specified for `:h nvim_set_hl`
        comments = {},
        keywords = {},
        functions = {},
        variables = {},
        type = {},
        lsp = {},
    }
})

vim.cmd("colorscheme no-clown-fiesta")
