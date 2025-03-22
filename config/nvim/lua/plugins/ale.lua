return {
	'dense-analysis/ale',
	config = function()
		local g = vim.g
		g.ale_ruby_rubocop_auto_correct_all = 1
		g.ale_linters = {
			ruby = { 'rubocop', 'ruby' },
      lua = { 'lua-format', 'luafmt', 'stylua' },
      python = { 'flake8', 'pylint', 'mypy' },
      java = { 'eclim' },
      rust = { 'rustfmt', 'cargo' },
      go = { 'golangci-lint' },
      kotlin = { 'ktlint' },
      bash = { 'shellcheck' },
      sh = { 'shellcheck' },
      json = { 'jsonlint' },
      toml = { 'tomllint' },
      javascript = { 'eslint', 'jshint' },
      typescript = { 'eslint' },
      html = { 'tidy' },
      css = { 'stylelint' },
      c = { 'clang-tidy' },
      cpp = { 'clang-tidy' },
      dockerfile = { 'hadolint' },
		}
	end
}
