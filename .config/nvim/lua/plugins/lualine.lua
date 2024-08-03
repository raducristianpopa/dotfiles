return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local noirbuddy_lualine = require("noirbuddy.plugins.lualine")

            -- local function truncate_branch_name(branch)
            --     if not branch or branch == "" then
            --         return ""
            --     end
            --
            --     -- Match the branch name to the specified format
            --     local user, team, ticket_number = string.match(branch, "^(%w+)/(%w+)%-(%d+)")
            --
            --     -- If the branch name matches the format, display {user}/{team}-{ticket_number}, otherwise display the full branch name
            --     if ticket_number then
            --         return user .. "/" .. team .. "-" .. ticket_number
            --     else
            --         return branch
            --     end
            -- end

            require("lualine").setup({
                options = {
                    theme = noirbuddy_lualine.theme,
                    globalstatus = true,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "█", right = "█" },
                },
                sections = noirbuddy_lualine.sections,
                inactive_sections = noirbuddy_lualine.inactive_sections,
                -- sections = {
                --     lualine_b = {
                --         { "branch", icon = "", fmt = truncate_branch_name },
                --         "diff",
                --         "diagnostics",
                --     },
                --     lualine_c = {
                --         { "filename", path = 1 },
                --     },
                --     lualine_x = {
                --         "filetype",
                --     },
                -- },
            })
        end,
    },
}
