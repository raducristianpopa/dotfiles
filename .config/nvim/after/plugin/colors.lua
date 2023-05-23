local status, rosepine = pcall(require, "rose-pine")
if (not status) then return end

rosepine.setup({
	--- @usage 'auto'|'main'|'moon'|'dawn'
    variant = "main",
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = false,
	disable_float_background = false,
	disable_italics = false,

	-- Change specific vim highlight groups
	-- https://github.com/rose-pine/neovim/wiki/Recipes
	highlight_groups = {
		ColorColumn = { bg = 'subtle' },
	}
})

-- Set colorscheme after options
vim.cmd("colorscheme rose-pine")