return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
     flavour = "mocha",
     custom_highlights = function(colors)
        return {
           WinSeparator = { fg = colors.surface0 },
        }
     end,
     color_overrides = {
        macchiato = {
        },
     },
     integrations = {
        notify = true,
     },
  },
  init = function()
    vim.cmd.colorscheme("catppuccin-macchiato")
  end,
}
