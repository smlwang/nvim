local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
local cmp = require("cmp")

local key_map = {
    -- Use <C-b/f> to scroll the docs
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- Use <C-k/j> to switch in items
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    -- Use <CR>(Enter) to confirm selection
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),


    -- A super tab
    -- sourc: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
            cmp.complete()
        else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
            cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
        end
    end, { "i", "s" }),
}

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert(key_map),

    -- Let's configure the item's appearance
    -- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
    formatting = {
        -- Set order from left to right
        -- kind: single letter indicating the type of completion
        -- abbr: abbreviation of "word"; when not empty it is used in the menu instead of "word"
        -- menu: extra text for the popup menu, displayed after "word" or "abbr"
        fields = { 'abbr', 'menu' },

        -- customize the appearance of the completion menu
        format = function(entry, vim_item)
            -- vim_item.menu = ({
            --     nvim_lsp = '[Lsp]',
            --     luasnip = '[Luasnip]',

            --     buffer = '[File]',
            --     path = '[Path]',
            -- })[entry.source.name]
            vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
            return vim_item
        end,
    },

    -- Set source precedence
    sources = cmp.config.sources({
        { name = 'vsnip' },
        { name = 'nvim_lsp' }, -- For nvim-lsp
    }, {
        { name = 'buffer' },   -- For buffer word completion
        { name = 'path' }      -- For path completion
    })
})

-- Use buffer source for `/`.
cmp.setup.cmdline({ '/', '?' }, {
    sources = {
        { name = 'buffer' }
    },
    mapping = cmp.mapping.preset.cmdline(key_map),
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    mapping = cmp.mapping.preset.cmdline(key_map),
})
