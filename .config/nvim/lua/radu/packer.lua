-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim");
    use {
        "nvim-telescope/telescope.nvim", tag = '0.1.1',
        -- or                            , branch = "0.1.x",
        requires = { {"nvim-lua/plenary.nvim"} }
    };
    use("nvim-treesitter/nvim-treesitter", { run = ':TSUpdate' });
    use("tpope/vim-fugitive");
    use("nvim-lualine/lualine.nvim");
    use("windwp/nvim-ts-autotag");
    use("MunifTanjim/prettier.nvim");
    use("jose-elias-alvarez/null-ls.nvim");
    use("lewis6991/gitsigns.nvim");
    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},             -- Required
            {                                      -- Optional
            "williamboman/mason.nvim",
            run = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },
        {"williamboman/mason-lspconfig.nvim"}, -- Optional

        -- Autocompletion
        {"hrsh7th/nvim-cmp"},     -- Required
        {"hrsh7th/cmp-nvim-lsp"}, -- Required
        {"L3MON4D3/LuaSnip"},     -- Required
    };

    use({ "rose-pine/neovim", as = 'rose-pine' });
}
end)
