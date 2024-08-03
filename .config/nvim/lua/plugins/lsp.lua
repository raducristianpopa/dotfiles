local nnoremap = require("radu.utils").nnoremap
local inoremap = require("radu.utils").inoremap

local map_lsp_keybinds = function(buffer_number)
    local telescope_builtin = require("telescope.builtin");
    nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
    nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })
    nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })
    nnoremap("gr", telescope_builtin.lsp_references, { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number })
    nnoremap("gi", telescope_builtin.lsp_implementations, { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number })
    nnoremap("<leader>bs", telescope_builtin.lsp_document_symbols, { desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number })
    nnoremap("<leader>ps", telescope_builtin.lsp_workspace_symbols, { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number })
    nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
    inoremap("<C-h>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
    nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
    nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
        dependencies = {
            -- Plugin(s) and UI to automatically install LSPs to stdpath
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Install lsp autocompletions
            "hrsh7th/cmp-nvim-lsp",

            -- Progress/Status update for LSP
            { "j-hui/fidget.nvim", opts = {} },

        },
        config = function()
            -- Default handlers for LSP
            local default_handlers = {
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
            }

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

            local format = require("conform").format

            -- Function to run when neovim connects to a Lsp client
            ---@diagnostic disable-next-line: unused-local
            local on_attach = function(_client, buffer_number)
                -- Pass the current buffer to map lsp keybinds
                map_lsp_keybinds(buffer_number)

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(buffer_number, "Format", function(_)
                    require("conform").format({})
                end, { desc = "LSP: Format current buffer with LSP" })

                vim.api.nvim_buf_create_user_command(buffer_number, "FormatGitHunks", function(_)
                    local ignore_filetypes = { "lua" }
                    if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
                        print("range formatting for " .. vim.bo.filetype .. " not working properly.")
                        return
                    end

                    local hunks = require("gitsigns").get_hunks()
                    if hunks == nil then
                        return
                    end

                    local function format_range()
                        if next(hunks) == nil then
                            return
                        end
                        local hunk = nil
                        while next(hunks) ~= nil and (hunk == nil or hunk.type == "delete") do
                            hunk = table.remove(hunks)
                        end

                        if hunk ~= nil and hunk.type ~= "delete" then
                            local start = hunk.added.start
                            local last = start + hunk.added.count
                            -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
                            local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
                            local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
                            format({ range = range, async = true, lsp_fallback = true }, function()
                                vim.defer_fn(function()
                                    format_range()
                                end, 1)
                            end)
                        end
                    end

                    format_range()
                end, { desc = "LSP: Format current buffer Git hunks with LSP" })
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
                prettier = {},
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
                tailwindcss = {},
                tsserver = {
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
            }

            local formatters = {
                prettierd = {},
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
                require("lspconfig")[name].setup({
                    autostart = config.autostart,
                    cmd = config.cmd,
                    capabilities = capabilities,
                    filetypes = config.filetypes,
                    handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
                    on_attach = on_attach,
                    settings = config.settings,
                    root_dir = config.root_dir,
                })
            end

            -- Setup mason so it can manage 3rd party LSP servers
            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })
            require("mason-lspconfig").setup()

            -- Configure borderd for LspInfo ui
            require("lspconfig.ui.windows").default_options.border = "rounded"

            -- Configure diagnostics border
            vim.diagnostic.config({
                float = {
                    border = "rounded",
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        -- event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            notify_on_error = false,
            default_format_opts = {
                async = true,
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            format_after_save = nil,
            format_on_save = nil,
            formatters_by_ft = {
                javascript = { "biome", "prettierd", "prettier" },
                typescript = { "biome", "prettierd", "prettier" },
                typescriptreact = { "biome", "prettierd", "prettier" },
                svelte = { "prettierd", "prettier " },
                lua = { "stylua" },
            },
        },
        keys = {},
    },
}
