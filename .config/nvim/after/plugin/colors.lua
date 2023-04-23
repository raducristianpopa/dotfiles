local palette = require('nordic.colors')

local status, nordic = pcall(require, "nordic")
if (not status) then return end

nordic.setup({
    theme = 'nordic',
    italic_comments = false,
    transparent_bg = true,
    bright_border = false,
    nordic = {
        reduced_blue = false,
    },
    cursorline = {
        bold = false,
        theme = 'dark',
        hide_unfocused = true,
    },
    override = {},
    telescope = {
        style = 'flat',
    },
})

vim.cmd.colorscheme 'nordic'
