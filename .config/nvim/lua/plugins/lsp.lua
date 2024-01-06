return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "nvimtools/none-ls.nvim",
            "folke/neodev.nvim",
            "j-hui/fidget.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            local map_lsp_keybinds = require("radu.keymaps").map_lsp_keybinds -- Has to load keymaps before pluginslsp

            require("neodev").setup()
            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })
            require("mason-lspconfig").setup({
                automatic_installation = { exclude = { "ocamllsp", "gleam" } },
            })

            local servers = {
                bashls = {},
                cssls = {},
                graphql = {},
                html = {},
                jsonls = {},
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

            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local code_actions = null_ls.builtins.code_actions

            null_ls.setup({
                border = "rounded",
                sources = {
                    -- formatting
                    formatting.prettier,
                    formatting.stylua,
                    formatting.ocamlformat,

                    -- diagnostics
                    diagnostics.eslint_d.with({
                        condition = function(utils)
                            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
                        end,
                    }),

                    -- code actions
                    code_actions.eslint_d.with({
                        condition = function(utils)
                            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
                        end,
                    }),
                },
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
    },
}
