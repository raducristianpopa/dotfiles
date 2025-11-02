local nnoremap = require("radu.utils").nnoremap
local inoremap = require("radu.utils").inoremap

local signature_help = function()
    return vim.lsp.buf.signature_help({ border = "rounded" })
end

local hover = function()
    return vim.lsp.buf.hover({ border = "rounded" })
end

local map_lsp_keybinds = function(buffer_number)
    local telescope_builtin = require("telescope.builtin");
    nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
    nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })
    nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })
    nnoremap("gr", telescope_builtin.lsp_references, { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number })
    nnoremap("gi", telescope_builtin.lsp_implementations, { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number })
    nnoremap("<leader>bs", telescope_builtin.lsp_document_symbols, { desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number })
    nnoremap("<leader>ps", telescope_builtin.lsp_workspace_symbols, { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number })
    nnoremap("K", hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
    inoremap("<C-h>", signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
    nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
    nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufReadPre", "BufNewFile", "BufEnter" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
    dependencies = {
        -- Plugin(s) and UI to automatically install LSPs to stdpath
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- Install lsp autocompletions
        "hrsh7th/cmp-nvim-lsp",

        -- Helm syntax and filetype
        { 'towolf/vim-helm', ft = 'helm' },

        -- Progress/Status update for LSP
        { "j-hui/fidget.nvim", opts = {} },

    },
    config = function()
        local tsserver_inlay_hints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        }

        -- Function to run when neovim connects to a Lsp client
        ---@diagnostic disable-next-line: unused-local
        local on_attach = function(_client, buffer_number)
            -- Pass the current buffer to map lsp keybinds
            map_lsp_keybinds(buffer_number)
        end

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP Specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

        local servers = {
            astro = {},
            bashls = {},
            cssls = {},
            eslint = {},
            graphql = {},
            html = {},
            svelte = {},
            jsonls = {},
            ocamllsp = {},
            rust_analyzer = {
                check = {
                    command = "clippy",
                }
            },
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            }
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        },
                        telemetry = { enabled = false },
                    },
                },
            },
            sqlls = {},
            gleam = {},
            tailwindcss = {},
            ts_ls= {
                settings = {
                    maxTsServerMemory = 12288,
                    typescript = {
                        inlayHints = tsserver_inlay_hints,
                    },
                    javascript = {
                        inlayHints = tsserver_inlay_hints,
                    },
                },
            },
            yamlls = {},
            gopls = {
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                            ST1000 = false,
                        },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            },
            helm_ls = {
                settings = {
                    ['helm-ls'] = {
                        yamlls = {
                            path = "yaml-language-server",
                        }
                    }
                }
            }
        }

        local formatters = {
            prettier = {},
            stylua = {},
        }

        local manually_installed_servers = { "rust_analyzer" }
        local mason_tools_to_install = vim.tbl_keys(vim.tbl_deep_extend("force", {}, servers, formatters))
        local ensure_installed = vim.tbl_filter(function(name)
            return not vim.tbl_contains(manually_installed_servers, name)
        end, mason_tools_to_install)

        require("mason-tool-installer").setup({
            auto_update = true,
            run_on_start = true,
            start_delay = 3000,
            debounce_hours = 12,
            ensure_installed = ensure_installed,
        })

        -- Iterate over the servers and set them up
        for name, config in pairs(servers) do
            vim.lsp.config(name, {
                autostart = config.autostart,
                cmd = config.cmd,
                capabilities = capabilities,
                filetypes = config.filetypes,
                handlers = vim.tbl_deep_extend("force", {}, config.handlers or {}),
                on_attach = on_attach,
                settings = config.settings,
                root_dir = config.root_dir,
            })
        end

        -- Setup mason so it can manage 3rd party LSP servers
        require("mason").setup({ ui = { border = "rounded" } })
        -- require("mason-lspconfig").setup()

        -- Configure borderd for LspInfo ui
        require("lspconfig.ui.windows").default_options.border = "rounded"

        -- Enable virtual lines for diagnostics
        vim.diagnostic.config({ float = { border = "rounded" } })
    end,
}
