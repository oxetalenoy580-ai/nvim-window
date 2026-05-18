if vim.g.neovide then
	vim.g.neovide_opacity = 0.7
	-- 仅编辑区透明（推荐，不影响标题栏）
	vim.g.neovide_normal_opacity = 0.7
	if vim.g.neovide then
		vim.o.guifont = "JetBrainsMono Nerd Font:h12"
	end
end
vim.g.neovide_corner_preference = "round"
vim.g.neovide_fullscreen = false
