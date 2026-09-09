vim.b.minisurround_config = {
  custom_surroundings = {
    -- ![](link)
    l = {
      output = { left = '![](', right = ')' },
    },
    -- markdown code fence (code is indented)
    -- FIXME: always indents content (treesitter?)
    c = {
      output = { left = '```', right = '```' },
    },
    C = {
      output = function()
        local lang = MiniSurround.user_input('Language')
        return { left = '```' .. lang, right = '```' }
      end,
    }
  },
}
