local status, lspzero = pcall(require, "lsp-zero")
if (not status) then return end

local _status, cmp = pcall(require, "cmp")
if (not _status) then return end

local __status, lspconfig = pcall(require, "lspconfig")
if (not __status) then return end

local lsp = lspzero.preset({})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
   ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
   ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
   ["<CR>"] = cmp.mapping.confirm({ select =true }),
   ["<C-space>"] = cmp.mapping.complete(),
})

lsp.ensure_installed({
	"tsserver",
    "svelte",
	"eslint",
	"rust_analyzer",
})

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(_, bufnr)
    local map = function (keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, remap = false, desc = desc })
    end

    map("gd", function() vim.lsp.buf.definition() end, "[G]oto [D]efinition")
    map("gi", function() vim.lsp.buf.implementation() end, "[G]oto [I]mplementation")
	map("K", function() vim.lsp.buf.hover() end, "Hover documentation")
    map("<C-k>", function() vim.lsp.buf.signature_help() end, "Signature documentation")
    map("<leader>ca", function() vim.lsp.buf.code_action() end, "[C]ode [A]ction")
    map("<leader>rn", function() vim.lsp.buf.rename() end, "[R]e[n]ame")
    map("<leader>vr", function() vim.lsp.buf.references() end, "[V]iew [R]eferences")

    map("<leader>e", function() vim.diagnostic.open_float() end, "Open floating diagnostic message")
    map("]d", function() vim.diagnostic.goto_next() end, "Go to next diagnostic message")
    map("[d", function() vim.diagnostic.goto_prev() end, "Go to previous diagnostic message")
end)

lsp.setup()
