local M = {}

local function next_diagnostic()
    local ok = pcall(vim.diagnostic.jump, { count = 1, float = false })
	if ok then
		vim.api.nvim_feedkeys("zz", "n", false)
    end
end

local function previous_diagnostic()
    local ok = pcall(vim.diagnostic.jump, { count = -1, float = false })
	if ok then
		vim.api.nvim_feedkeys("zz", "n", false)
    end
end

local function next_error()
	local ok = pcall(vim.diagnostic.jump, { count = 1, severity = vim.diagnostic.severity.ERROR, float = false })
	if ok then
		vim.api.nvim_feedkeys("zz", "n", false)
	end
end

local function previous_error()
    local ok = pcall(vim.diagnostic.jump, { count = -1, severity = vim.diagnostic.severity.ERROR, float = false })
	if ok then
		vim.api.nvim_feedkeys("zz", "n", false)
    end
end

local function next_warning()
	local ok = pcall(vim.diagnostic.jump, { count = 1, severity = vim.diagnostic.severity.WARN, float = false })
	if ok then
		vim.api.nvim_feedkeys("zz", "n", false)
	end
end

local function previous_warning()
    local ok = pcall(vim.diagnostic.jump, { count = -1, severity = vim.diagnostic.severity.WARN, float = false })
	if ok then
		vim.api.nvim_feedkeys("zz", "n", false)
	end
end

local function open_float()
  vim.diagnostic.open_float({ border = "rounded" })
end

M.next_diagnostic = next_diagnostic
M.previous_diagnostic = previous_diagnostic
M.next_error = next_error
M.previous_error = previous_error
M.next_warning = next_warning
M.previous_warning = previous_warning
M.open_float = open_float

return M
