return {
	'monkoose/matchparen.nvim',
	config = function()
		require('matchparen').setup {
			on_startup = true, -- Should it be enabled by default
			hl_group = 'MatchParen', -- highlight group of the matched brackets
			debounce_time = 100, -- debounce time in milliseconds for rehighlighting of brackets.
		}	
	end,
}
