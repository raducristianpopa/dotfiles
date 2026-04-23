local M = {}

local function bind(op, outer_opts)
    outer_opts = vim.tbl_extend("force", { noremap = true, silent = true }, outer_opts or {})

    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force", outer_opts, opts or {})
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

local function open_link()
	local line = vim.fn.getline(".")
	local col = vim.fn.col(".")

	-- Pattern for markdown links: [text](url)
	local md_link_pattern = "%[.-%]%((.-)%)"
	-- Pattern for bare URLs (simplified, covers most cases)
	local url_pattern = "https?://[%w-_%.%?%.:/%+=&]+"

	-- Check if cursor is on a markdown link
	local start_pos = 1
	while true do
		local md_start, md_end, url = line:find(md_link_pattern, start_pos)
		if not md_start then
			break
		end

		if col >= md_start and col <= md_end then
			vim.fn.system("open " .. vim.fn.shellescape(url))
			return
		end
		start_pos = md_end + 1
	end

	-- Check for URLs (including those in parentheses)
	start_pos = 1
	while true do
		local url_start, url_end = line:find(url_pattern, start_pos)
		if not url_start then
			break
		end

		if col >= url_start and col <= url_end then
			local url = line:sub(url_start, url_end)
			vim.fn.system("open " .. vim.fn.shellescape(url))
			return
		end
		start_pos = url_end + 1
	end

	-- Fallback to original behavior using cWORD
	vim.cmd("sil !open <cWORD>")
end

local function find_and_replace_termcodes() 
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

M.nmap = bind("n", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")
M.tnoremap = bind("t")

M.open_link = open_link
M.find_and_replace_termcodes = find_and_replace_termcodes

return M
