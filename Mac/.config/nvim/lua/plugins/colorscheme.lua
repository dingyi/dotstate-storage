return {
	{
		"wongmjane/nerv-theme",
		lazy = false,
		priority = 1000,
		config = function()
			-- Theme lives in neovim-theme/ subfolder; add it to rtp so colors/nerv.lua is found
			local nerv_theme_path = vim.fn.stdpath("data") .. "/lazy/nerv-theme/neovim-theme"
			if vim.fn.isdirectory(nerv_theme_path) == 1 then
				vim.opt.rtp:prepend(nerv_theme_path)
			end
			vim.cmd([[colorscheme nerv]])
		end,
	},
}
