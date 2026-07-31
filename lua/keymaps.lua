-- ~/.config/nvim/lua/configs.lua

local opts = { silent = true, noremap = true }

-- neovim {{{
-- Close all folds except current one (great for focus)
-- update packages
vim.keymap.set('n', '<f12>', '<cmd>lua vim.pack.update()<cr>', { desc = 'Update neovim packages' })
-- folke/flash.nvim
vim.keymap.set('n', '\\', '<cmd>lua require("flash").jump()<cr>', { desc = 'folke/flash.nvim jump' })
-- Smart fold navigation (closes current, opens next/previous)
vim.keymap.set('n', 'zv', 'zMzvzz', { desc = 'Close all folds except the current one' })
vim.keymap.set('n', 'zj', 'zcjzOzz', { desc = 'Close current fold when open. Always open next fold.' })
vim.keymap.set('n', 'zk', 'zckzOzz', { desc = 'Close current fold when open. Always open previous fold.' })
-- escape in insert mode leaves cursor in the same position
vim.keymap.set('i', '<Esc>', '<Esc>`^', opts)
-- escape in normal mode turns off search highlight (TODO: find better alternative)
vim.keymap.set('n', '<Esc>', '<Cmd>noh<CR>', opts) -- ESC disables highlight search
-- cursor in insert mode
vim.keymap.set('i', '<C-h>', '<Left>', opts)
vim.keymap.set('i', '<C-j>', '<Down>', opts)
vim.keymap.set('i', '<C-k>', '<Up>', opts)
vim.keymap.set('i', '<C-l>', '<Right>', opts)
vim.keymap.set('i', '<C-a>', '<Home>', opts)
vim.keymap.set('i', '<C-e>', '<End>', opts)
-- paste over selected text multiple times (visual then <leader>pppp)
vim.keymap.set('x', '<Leader>p', '"_dP', { desc = 'paste over visual multiple times' })
-- yank to system clipboard
vim.keymap.set({'n', 'x'}, '<Leader>y', '"+y', { desc = 'yank to system clipboard' })
vim.keymap.set('n', '<Leader>Y', '"+Y', { desc = 'yank to system clipboard' })
vim.keymap.set({'n', 'x'}, '<Leader>p', '"+p', { desc = 'past from system clipboard' })
-- join does not change cursor position
vim.keymap.set('n', 'J', 'mzJ`z', opts)
-- scroll
vim.keymap.set('n', '<M-k>', '<C-y>k', opts)  -- vertical scroll
vim.keymap.set('n', '<M-j>', '<C-e>j', opts)
vim.keymap.set('n', '<M-h>', 'zhh', opts)     -- horizontal scroll
vim.keymap.set('n', '<M-l>', 'zll', opts)
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts) -- center on page up/down
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
-- search centers and open folds if needed
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
-- increase/decrease foldlevel, toggle fold
-- Eveything above foldlevel is hidden. If foldlevel=0 everything is hidden.
vim.keymap.set('n', '+', 'zm', opts) -- fold more (decreases foldlevel towards 0)
vim.keymap.set('n', '-', 'zr', opts) -- fold less (increases foldlevel)
vim.keymap.set('n', '<BS>', 'za', opts)   -- toggle 1 level
vim.keymap.set('n', '<S-BS>', 'zA', opts) -- toggle recursively
-- stay in visual mode
vim.keymap.set('v', '>', '>gv', opts)
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '<C-a>', '<C-a>gv', opts)
vim.keymap.set('v', '<C-x>', '<C-x>gv', opts)
vim.keymap.set('v', 'g<C-a>', 'g<C-a>gv', opts)
vim.keymap.set('v', 'g<C-x>', 'g<C-x>gv', opts)
-- select line / entire buffer
vim.keymap.set('n', 'VV', 'ggVG', { desc = 'select entire buffer' })
vim.keymap.set('n', 'vv', '^vg_', { desc = 'select visible chars in line' })
-- toggle wrap, list, background
vim.keymap.set('n', '<F8>', '<cmd>set list!<CR>', opts)
vim.keymap.set('n', '<F20>', '<cmd>set wrap!<CR>', opts) -- <Shift-F8>
vim.keymap.set('n', '<F7>', function() -- toggle inlay hints
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, opts)
vim.keymap.set('n', '<f6>', function()
  if vim.api.nvim_get_option_value('background', {}) == 'dark' then
    vim.api.nvim_set_option_value('background', 'light', {})
  else
    vim.api.nvim_set_option_value('background', 'dark', {})
  end
end)
-- toggle spell, set spelllang
vim.keymap.set('n', '<F9>', '<cmd>set spell!<CR>', opts)
vim.keymap.set('n', '<F21>', function() -- swap language pt/en <Shift-F9>
  if vim.api.nvim_get_option_value('spelllang', {}) == 'en' then
    vim.api.nvim_set_option_value('spelllang', 'pt_pt', {})
  else
    vim.api.nvim_set_option_value('spelllang', 'en', {})
  end
end, opts)
-- switch windows
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
-- cycle buffers, delete buffer
vim.keymap.set('n', '<M-[>', '<CMD>bp<CR>', opts) -- previous buffer
vim.keymap.set('n', '<M-]>', '<CMD>bn<CR>', opts) -- next buffer
vim.keymap.set('n', '<M-b>', '<Cmd>confirm bdelete<CR>', opts) -- delete buffer
-- close window, quit, force quit
vim.keymap.set('n', '<M-w>', '<Cmd>confirm close<CR>', opts)
vim.keymap.set('n', '<M-q>', '<Cmd>confirm quitall<CR>', opts)
vim.keymap.set('n', '<S-M-q>', '<Cmd>quitall!<CR>', opts)
-- split window horizontal/vertical
vim.keymap.set('n', '<leader>-', '<Cmd>split<CR>', opts)
vim.keymap.set('n', '<leader>|', '<Cmd>vsplit<CR>', opts)
-- change window to horizontal/vertical split
vim.keymap.set('n', '<leader>wh', '<C-w>t<C-w>H', opts)
vim.keymap.set('n', '<leader>wv', '<C-w>t<C-w>K', opts)
-- insert new lines above/below
vim.keymap.set('i', '<S-CR>', '<C-o>O', opts)
vim.keymap.set('i', '<C-CR>', '<C-o>o', opts) -- LSP
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostics floating' })
vim.keymap.set('n', '<Leader>l', vim.diagnostic.setloclist, { desc = 'Add diagnostics to location list' })
--
-- }}}

-- mini.surround {{{
vim.keymap.set('n', 'S', 's$', { remap = true }) -- surround to EOL
vim.keymap.set('n', 'ss', '^sg_', { remap = true }) -- surround visible chars in line
-- }}}

-- telescope {{{
vim.keymap.set('n', '<Leader>f<Space>', '<Cmd>Telescope<CR>', opts)
vim.keymap.set('n', '<Leader>f/', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', opts)
vim.keymap.set('n', '<Leader>fj', '<Cmd>Telescope jumplist<CR>', opts)
vim.keymap.set('n', '<Leader>f"', '<Cmd>Telescope registers<CR>', opts)
vim.keymap.set('n', '<Leader>fm', '<Cmd>Telescope marks<CR>', opts)

vim.keymap.set('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', opts)
vim.keymap.set('n', '<Leader>fr', '<Cmd>Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<Leader>fcs', '<Cmd>Telescope colorscheme<CR>', opts)
vim.keymap.set('n', '<Leader>fss', '<Cmd>Telescope spell_suggest<CR>', opts)
vim.keymap.set('n', '<Leader>fd', '<Cmd>Telescope diagnostics<CR>', opts)
vim.keymap.set('n', '<Leader>f?', '<Cmd>Telescope man_pages sections=ALL<CR>', opts)
vim.keymap.set('n', '<Leader>fb', '<Cmd>Telescope buffers<CR>', opts)
vim.keymap.set('n', '<Leader>fk', '<Cmd>Telescope keymaps<CR>', opts)
vim.keymap.set('n', '<Leader>fvim', '<Cmd>Telescope vim_options<CR>', opts)

-- history
vim.keymap.set('n', '<Leader>fof', '<Cmd>Telescope oldfiles<CR>', opts)
vim.keymap.set('n', '<Leader>fsh', '<Cmd>Telescope search_history<CR>', opts)
vim.keymap.set('n', '<Leader>fch', '<Cmd>Telescope command_history<CR>', opts)
vim.keymap.set('n', '<Leader>fqh', '<Cmd>Telescope quickfixhistory<CR>', opts)

-- LSP
vim.keymap.set('n', '<Leader>flr', '<Cmd>Telescope lsp_references<CR>', opts)
vim.keymap.set('n', '<Leader>fld', '<Cmd>Telescope lsp_definitions<CR>', opts)
vim.keymap.set('n', '<Leader>flt', '<Cmd>Telescope lsp_type_definitions<CR>', opts)
vim.keymap.set('n', '<Leader>fli', '<Cmd>Telescope lsp_incoming_calls<CR>', opts)
vim.keymap.set('n', '<Leader>flo', '<Cmd>Telescope lsp_outgoing_calls<CR>', opts)

-- Treesitter
    -- { '<Leader>fT', '<Cmd>Telescope treesitter<CR>', desc = 'Treesitter (Telescope)' },
    -- { '<leader>ft', '<cmd>TodoTelescope<cr>', desc = 'Todo (Telescope)' },

-- Git
vim.keymap.set('n', '<Leader>fgb', '<Cmd>Telescope git_branches<CR>', opts)
vim.keymap.set('n', '<Leader>fgc', '<Cmd>Telescope git_bcommits<CR>', opts) -- current buffer
vim.keymap.set('n', '<Leader>fgC', '<Cmd>Telescope git_commits<CR>', opts) -- current directory
vim.keymap.set('n', '<Leader>fgf', '<Cmd>Telescope git_files<CR>', opts)
vim.keymap.set('n', '<Leader>fgs', '<Cmd>Telescope git_status<CR>', opts)
vim.keymap.set('n', '<Leader>fgS', '<Cmd>Telescope git_stash<CR>', opts)

-- Other
    -- { '<Leader>fh', '<Cmd>Telescope hoogle<CR>', desc = 'Hoogle search (Telescope)' },
-- }}}

-- lsp {{{
vim.keymap.set({ 'n', 'x' }, 'grf', '<Cmd>lua vim.lsp.buf.format()<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- }}}

-- vim:foldmethod=marker:foldenable
