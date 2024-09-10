return {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
        { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
        { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/dev/snaps" },
    },
    config = function ()
        require('codesnap').setup({
            mac_window_bar = true,
            title = "CodeSnap",
            code_font_family = "Iosevka Term",
            watermark = "",
            save_path = "~/dev/snaps",
            bg_theme = "grape",
            has_breadcrumbs = false,
            has_line_number = true,
            show_workspace = false,
            min_width = 0,
            bg_x_padding = 122,
            bg_y_padding = 82,
        })
    end
}
