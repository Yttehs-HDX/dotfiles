return {
    'L3MON4D3/LuaSnip',
    lazy = true,
    event = { 'InsertEnter' },
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
        -- include friendly snipepts to luasnip
        require('luasnip.loaders.from_vscode').lazy_load()

        local ls = require('luasnip')

        -- some shorthands from
        -- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
        local s = ls.snippet
        local sn = ls.snippet_node
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        local c = ls.choice_node
        local d = ls.dynamic_node
        local r = ls.restore_node
        local l = require('luasnip.extras').lambda
        local rep = require('luasnip.extras').rep
        local p = require('luasnip.extras').partial
        local m = require('luasnip.extras').match
        local n = require('luasnip.extras').nonempty
        local dl = require('luasnip.extras').dynamic_lambda
        local fmt = require('luasnip.extras.fmt').fmt
        local fmta = require('luasnip.extras.fmt').fmta
        local types = require('luasnip.util.types')
        local conds = require('luasnip.extras.expand_conditions')

        -- Returns a snippet_node wrapped around an insert_node whose initial
        -- text value is set to the current date in the desired format.
        local date_input = function(_, _, format) return os.date(format) end

        local shebang = function(_, _)
            local sb = '#!/usr/bin/env '
            local ft = vim.bo.filetype
            if ft then
                return sb .. ft
            else
                return sb
            end
        end

        local func_wrapper = function(func, args) return f(func, {}, { user_args = args }) end

        ls.config.set_config({ enable_autosnippets = true })

        ls.add_snippets(nil, {
            all = {
                s('test', { t('this is a test') }),
            },
        })
        ls.add_snippets('python', {
            s(
                'startmain',
                fmt(
                    [[#!/usr/bin/env python

def {}() -> None:
    pass


if __name__ == "__main__":
    {}()]],
                    { i(1, 'main'), rep(1) }
                )
            ),
        })

        -- set type to "autosnippets" for adding autotriggered snippets (iabbrevations).
        ls.add_snippets('all', {
            s('shrug ', t('¯\\_(ツ)_/¯')),
            s('tableflip ', t('(╯°□°）╯彡┻━┻')),
            s('_me ', t('mitschix (23629789+mitschix@users.noreply.github.com)')),
            s('_github ', t('mitschix https://github.com/mitschix')),
            s('_gitlab ', t('mitschix 10944515-mitschix@users.noreply.gitlab.com')),
            s('_t ', { func_wrapper(date_input, { '%H:%M:%S' }) }),
            s('_ds ', { func_wrapper(date_input, { '%Y-%m-%d' }) }),
            s('_d ', { func_wrapper(date_input, { '%a, %d %b %Y' }) }),
            s('_dt ', { func_wrapper(date_input, { '%a, %d %b %Y %H:%M:%S' }) }),
            s('#!! ', f(shebang)),
        }, {
            type = 'autosnippets',
            key = 'all_auto',
        })
    end,
}
