	return {
	{
		-- "craftzdog/solarized-osaka.nvim",
		-- 'datsfilipe/vesper.nvim',
		'wongmjane/nerv-theme',
		priority = 1000,
		init = function()
			-- nerv-theme is a monorepo, the neovim colorscheme is in the neovim-theme subdirectory
			local nerv_path = vim.fn.stdpath("data") .. "/lazy/nerv-theme/neovim-theme"
			vim.opt.rtp:prepend(nerv_path)
		end,
		opts = {
			transparent = false,
		},
	},
}
