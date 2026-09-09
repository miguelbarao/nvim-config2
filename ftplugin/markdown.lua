vim.b.minisurround_config = {
  custom_surroundings = {
    -- Markdown Links ![description](link)
    l = {
      output = { left = '![](', right = ')' },
    },
    -- Markdown code fence. Asks for language.
    -- NOTE: L-VISUAL indents contents, VISUAL doesn't
    -- Use `vipv` instead of `vip` to prevent paragraph indentation.
    c = {
      output = function()
        local lang = MiniSurround.user_input('Language')
        return { left = '```' .. lang .. '\n', right = '\n```' }
      end,
    }
  },
}
