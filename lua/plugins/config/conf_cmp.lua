local cmp = require("cmp")
local luasnip = require('luasnip')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

return {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)  -- LuaSnip expansion
    end,
  },
  -- Mapping completion keys
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirm with Enter key
      ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),

  -- Configure sources for nvim-cmp
  sources = {
    { name = 'nvim_lsp', max_item_count = 10},    -- LSP source
    { name = 'luasnip_choice' },
    { name = 'luasnip' },     -- LuaSnip source (if using snippets)
    { name = 'buffer' },      -- Buffer source
    { name = 'path' },        -- Path source
  },

  -- Additional settings
    experimental = {
    ghost_text = true,  -- Optional: Display inline suggestions
  },
}

