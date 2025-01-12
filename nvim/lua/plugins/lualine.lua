return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local noirbuddy_lualine = require("noirbuddy.plugins.lualine")

            require("lualine").setup({
                options = {
                    theme = noirbuddy_lualine.theme,
                    globalstatus = true,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "█", right = "█" },
                },
                sections = noirbuddy_lualine.sections,
                inactive_sections = noirbuddy_lualine.inactive_sections,
            })
        end,
    },
}
