return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		require('bufferline').setup {
			options = {
				seperator_style = "thin",
			},
			highlights = require('catppuccin.groups.integrations.bufferline').get(),
		}
	end
}
