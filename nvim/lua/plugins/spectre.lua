local map_spectre_keybinds = require("radu.keymaps").map_spectre_keybinds

return {
    "nvim-pack/nvim-spectre",
    lazy = false,
    cmd = { "Spectre" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local spectre = require("spectre")

        spectre.setup({
            highlight = {
                search = "SpectreSearch",
                replace = "SpectreReplace",
            },
            mapping = {
                ["send_to_qf"] = {
                    map = "<C-q>",
                    cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                    desc = "send all items to quickfix",
                },
            },
            replace_engine = {
                sed = {
                    cmd = "sed",
                },
            },
        })

        map_spectre_keybinds(spectre)
    end,
}
