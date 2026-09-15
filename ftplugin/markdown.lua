vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 80

vim.b.minisurround_config = {
  custom_surroundings = {
    -- Markdown Links ![description](link)
    l = {
      output = { left = '![](', right = ')' },
    },
    -- Markdown code fence. Asks for language.
    -- NOTE: put the cursor in the empty line before the code block and
    -- VISUAL select (not L-VISUAL) to the empty line after the block.
    c = {
      output = function()
        local lang = MiniSurround.user_input('Language')
        return { left = "\n```" .. lang, right = "```\n" }
      end,
    }
  },
}
