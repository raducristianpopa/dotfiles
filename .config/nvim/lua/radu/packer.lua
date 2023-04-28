local plugins = {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = { { "nvim-lua/plenary.nvim" } },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        { run = ":TSupdate" },
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            { "neovim/nvim-lspconfig" },
            {
                "williamboman/mason.nvim",
                run = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            {"williamboman/mason-lspconfig.nvim"},

            {"hrsh7th/nvim-cmp"},
            {"hrsh7th/cmp-nvim-lsp"},
            {"L3MON4D3/LuaSnip"},
        },
    },
    "christoomey/vim-tmux-navigator",
    "tpope/vim-fugitive",
    "nvim-lualine/lualine.nvim",
    "windwp/nvim-ts-autotag",
    "MunifTanjim/prettier.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "lewis6991/gitsigns.nvim",
    {
        "AlexvZyl/nordic.nvim",
        as = "nordic",
    },
    "rebelot/kanagawa.nvim"
};

-- Plugin Setup
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    print(install_path)
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    for _, plugin in pairs(plugins) do
        use(plugin)
    end

    if packer_bootstrap then
        require("packer").sync()
    end
end)
