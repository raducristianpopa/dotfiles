return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local status, lualine = pcall(require, "lualine")
        if (not status) then return end

        lualine.setup {
            options = {
                theme = "tokyonight",
                icons_enabled = true,
                disabled_filetypes = {},
                section_separators = {},
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        path = 1, -- Just file name
                    }
                },
                lualine_x = {
                    { "diagnostics", source = { "nvim_diagnostics" } },
                    "filetype"
                }
            },
        }
    end
}
