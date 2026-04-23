local map_harpoon_keybinds = require("radu.keymaps").map_harpoon_keybinds

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        map_harpoon_keybinds(harpoon)
    end
}
