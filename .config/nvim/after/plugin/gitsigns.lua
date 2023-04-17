local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

gitsigns.setup {
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        changedelete = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
    },

    signcolumn = true;
    numhl      = true,
    linehl     = false,
    word_diff  = false,
}
