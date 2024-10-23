return {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
        'onsails/lspkind.nvim',
        'hrsh7th/cmp-nvim-lsp',
        -- "hrsh7th/cmp-nvim-lua",
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-cmdline',
        'ray-x/cmp-treesitter',
        'f3fora/cmp-spell',
        'tzachar/cmp-tabnine',
        { 'saadparwaiz1/cmp_luasnip', dependencies = 'L3MON4D3/LuaSnip' },
    },
    config = function()
        -- setup completion menu
        local cmp = require('cmp')
        local ls = require('luasnip')

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
        end

        cmp.setup({
            formatting = {
                format = require('lspkind').cmp_format({
                    mode = 'symbol_text',
                    menu = {
                        buffer = '[Buffer]',
                        nvim_lsp = '[LSP]',
                        luasnip = '[LSNIP]',
                        treesitter = '[TS]',
                        spell = '[Spll]',
                        cmp_tabnine = '[TN]',
                        calc = '[Calc]',
                        emoji = '[Emoji]',
                    },
                }),
            },
            sources = {
				{ name = "copilot" },
                { name = 'luasnip' },
                { name = 'nvim_lsp', priority = 100 },
                { name = 'cmp_tabnine' },
                { name = 'buffer', keyword_length = 5 },
                { name = 'path' },
                { name = 'calc' },
                { name = 'emoji' },
                { name = 'spell' },
                { name = 'treesitter', keyword_length = 5 },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif ls.expand_or_jumpable() then
                        ls.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif ls.jumpable(-1) then
                        ls.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    ls.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline({
                ['<C-e>'] = { c = cmp.mapping.close() },
            }),
            sources = { { name = 'buffer' } },
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline({
                ['<C-e>'] = { c = cmp.mapping.close() },
            }),
            sources = { { name = 'path' }, { name = 'cmdline' } },
        })
    end,
}
