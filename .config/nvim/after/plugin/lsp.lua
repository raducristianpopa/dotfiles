local lsp = require('lsp-zero').preset({})
local cmp = require('cmp')

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
   ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
   ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
   ["<C-y>"] = cmp.mapping.confirm({ select =true }),
   ["<C-space>"] = cmp.mapping.complete(),
})

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"rust_analyzer",
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

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
