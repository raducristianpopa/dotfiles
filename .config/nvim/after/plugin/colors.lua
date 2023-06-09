local status, nightfox = pcall(require, "nightfox")
if (not status) then return end

-- Default options
nightfox.setup({
    groups = {
        all = {
            EndOfBuffer = { link = "Conceal" },
        }
    }
})

vim.cmd("colorscheme no-clown-fiesta")
