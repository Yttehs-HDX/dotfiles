return {
	'anuvyklack/pretty-fold.nvim',
	dependencies = 'anuvyklack/keymap-amend.nvim',
	config = function()
		local pretty_fold = require('pretty-fold')
		pretty_fold.setup{
			keep_indentation = false,
			fill_char = '•',
			sections = {
				left = {
					'+', function() return string.rep('-', vim.v.foldlevel) end,
					' ', 'number_of_folded_lines', ':', 'content',
				}
			}
		}
		pretty_fold.ft_setup('lua', {
		matchup_patterns = {
				{ '^%s*do$', 'end' }, -- do ... end blocks
				{ '^%s*if', 'end' },  -- if ... end
				{ '^%s*for', 'end' }, -- for
				{ 'function%s*%(', 'end' }, -- 'function( or 'function (''
				{  '{', '}' },
				{ '%(', ')' }, -- % to escape lua pattern char
				{ '%[', ']' }, -- % to escape lua pattern char
			},
		})
	end
}
