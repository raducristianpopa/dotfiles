local nnoremap = require("radu.utils").nnoremap
local inoremap = require("radu.utils").inoremap

local map_lsp_keybinds = function(buffer_number)
    local telescope_builtin = require("telescope.builtin");
    nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
    nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })
    nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })
    nnoremap("gr", telescope_builtin.lsp_references, { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number })
    nnoremap("gi", telescope_builtin.lsp_implementations,
        { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number })
    nnoremap("<leader>bs", telescope_builtin.lsp_document_symbols,
        { desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number })
    nnoremap("<leader>ps", telescope_builtin.lsp_workspace_symbols,
        { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number })
    nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
    inoremap("<C-h>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
    nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
    nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "nvimtools/none-ls.nvim",
        "folke/neodev.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        require("neodev").setup()
        require("mason").setup({
            ui = {
                border = "rounded",
            },
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "tsserver",
                "eslint",
                "astro",
                "svelte",
                "tailwindcss",
                "astro"
            },
            automatic_installation = { exclude = { "ocamllsp", "gleam" } },
        })

        local servers = {
            astro = {},
            bashls = {},
            eslint = {},
            cssls = {},
            graphql = {},
            html = {},
            svelte = {},
            jsonls = {},
            intelephense = {},
            rust_analyzer = {},
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enabled = false },
                    },
                },
            },
            tailwindcss = {},
            tsserver = {
                settings = {
                    experimental = {
                        enableProjectDiagnostics = true,
                    },
                },
            },
        }

        -- Default handlers for LSP
        local default_handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
        }

        -- nvim-cmp supports additional completion capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local default_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        ---@diagnostic disable-next-line: unused-local
        local on_attach = function(_client, buffer_number)
            map_lsp_keybinds(buffer_number)

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(buffer_number, "Format", function(_)
                vim.lsp.buf.format({
                    filter = function(format_client)
                        -- Use Prettier to format TS/JS if it's available
                        return format_client.name ~= "tsserver" or not null_ls.is_registered("prettier")
                    end,
                })
            end, { desc = "LSP: Format current buffer with LSP" })
        end

        for name, config in pairs(servers) do
            require("lspconfig")[name].setup({
                capabilities = default_capabilities,
                filetypes = config.filetypes,
                handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
                on_attach = on_attach,
                settings = config.settings,
            })
        end

        null_ls.setup({
            border = "rounded",
        })

        -- Configure borderd for LspInfo ui
        require("lspconfig.ui.windows").default_options.border = "rounded"

        -- Configure diagostics border
        vim.diagnostic.config({
            float = {
                border = "rounded",
            },
        })
    end,
}
