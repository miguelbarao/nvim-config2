
require('configs') -- ~/.config/nvim/lua/configs.lua
require('keymaps') -- ~/.config/nvim/lua/keymaps.lua
require('autocmd') -- ~/.config/nvim/lua/autocmd.lua

-- :Trim command to remove trailing whitespaces from the entire buffer
vim.api.nvim_create_user_command('Trim', function()
  local cursor_pos = vim.fn.getpos('.')
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos('.', cursor_pos)
end, {})

-- :Update command to update neovim packages (:w to apply, :q to abort)
vim.api.nvim_create_user_command('Update', function()
  vim.cmd('lua vim.pack.update()')
end, {})

-- Plugins {{{
vim.pack.add({
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-tree/nvim-web-devicons', -- telescope dependency
  'https://github.com/nvim-lua/plenary.nvim',       -- telescope dependency
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/folke/flash.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  { src = 'https://github.com/mrcjkb/haskell-tools.nvim', version = vim.version.range('^10') },
  'https://github.com/DetachHead/basedpyright.git',
  'https://github.com/selimacerbas/live-server.nvim', -- markdown-preview dependency
  'https://github.com/selimacerbas/markdown-preview.nvim',
})
-- :lua vim.pack.update() and then :write to confirm or :quit to cancel
-- :lua vim.pack.del({ 'nvim-lspconfig', ... }) to uninstall packages
-- :TSUpdate updates the TreeSitter language parsers
-- }}}
-- Plugin settings {{{

-- markdown-preview
require('markdown_preview').setup({
  default_theme = "light"
})

-- indent-blankline
local hooks=require('ibl.hooks')
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'IblScope', { fg = '#98C379' })
end)
require('ibl').setup({            -- indent-blankline
  indent = { char = '▏' },
  scope = {
    char = '▎',
    highlight = { 'IblScope' }
  }
})

require('mini.icons').setup()
require('mini.completion').setup()-- <c-n>/<c-p>, <CR>, <c-l>/<c-h>  FIXME shortcut to accept?
require('mini.snippets').setup()  -- TODO
require('mini.diff').setup()
require('mini.ai').setup()        -- around/inner text objects
require('mini.align').setup()     -- align text interactively
require('mini.pairs').setup()     -- automatically closes parenthesis
require('mini.jump').setup()      -- f,F,t,T to work over multiple lines
require('mini.splitjoin').setup() -- gS toggles split/join
require('mini.tabline').setup({
  format = function(buf_id, label)
    local suffix = vim.bo[buf_id].modified and '• ' or '' -- show modified buffers
    return MiniTabline.default_format(buf_id, label) .. suffix
  end
})
require('mini.surround').setup({
  highlight_duration = 1000,
  mappings = { add = 's', delete = 'ds', replace = 'cs' },
  respect_selection_type = true,
})
require('mini.hipatterns').setup({
  highlighters = {
    fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
    hack  = { pattern = 'HACK', group = 'MiniHipatternsHack' },
    todo  = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
    note  = { pattern = 'NOTE', group = 'MiniHipatternsNote' },
  }
})

require('telescope').setup({
  defaults = {
    prompt_prefix = '  ',
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
      },
      width = 0.95,
      height = 0.80,
      preview_cutoff = 120,
    },
    border = true,
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false for exact matching
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
  },
})

-- treesitter
require('nvim-treesitter').install({
  'asm', 'bash', 'bibtex', 'c', 'cpp', 'css', 'csv', 'haskell', 'html',
  'javascript', 'json', 'kitty', 'latex', 'lua', 'make', 'markdown',
  'markdown_inline', 'objdump', 'python', 'regex', 'rust', 'scheme',
  'ssh_config', 'tmux', 'toml', 'yaml', 'zsh'
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'asm', 'bash', 'c', 'haskell', 'html', 'javascript', 'latex', 'markdown', 'python', 'rust', 'yaml', 'zsh' },
  callback = function()
    vim.treesitter.start()

    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- experimental
  end,
})

-- }}}
-- LSP {{{
vim.lsp.enable({
  -- `sudo apt install clangd`
  'clangd',

  -- Ubuntu:
  --   requires clang
  --   build with `make.sh` in `~/Repos/lua-language-server`
  --   link in ~/.local/bin/
  'lua_ls',

  -- update with `cargo install texlab`. Installed in `.cargo/bin`
  'texlab',

  -- `rustup component add rust-analyzer`. Installed in `.cargo/bin`
  'rust_analyzer',

  -- FreeBSD: installed with `pkg install ruff`. Add `lsp/ruff.lua`.
  -- Ubuntu:
  --   install uv: `curl -LsSf https://astral.sh/uv/install.sh | sh` on ~/.local/bin
  --   then: `uv tool install ruff@latest`, also installed on ~/.local/bin
  'ruff',
  -- Ubuntu:
  --   uv tool install basedpyright
  'basedpyright',

  -- Couldn't read configuration for RISC-V. Not worth the assle in my opinion
  -- see also the lsp configuration in 'lsp/asm-lsp.lua'
  -- 'asm-lsp', -- apt install libssl-dev; cargo install asm-lsp

  -- TODO:
    -- 'pest_ls',
    -- 'yamlls', -- requires npm which brings a tone of stuff...
})
-- See LSP configuration files in lsp/language_server.lua
vim.lsp.codelens.enable(true)
-- }}}

vim.cmd.colorscheme('retrobox')

-- vim:foldmethod=marker:foldenable
