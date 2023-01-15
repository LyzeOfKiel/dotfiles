function ColorMyPencils(color)
	vim.o.background = "light"
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()
