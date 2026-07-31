-- ~/.config/nvim/lua/configs.lua

vim.g.tex_flavor = 'latex' -- filetype for tex files [plain|context|latex]
-- vim.g.node_host_prog = '/usr/local/bin/neovim-node-host'
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-------------------------------------------------------------------------------
vim.opt.winborder = 'none'    -- border of floating windows (single, none)
vim.opt.lazyredraw = false    -- redraw during macros
vim.opt.shortmess:append('I') -- prevent :intro when starting neovim
vim.opt.timeout = true        -- use with timeoutlen
vim.opt.timeoutlen = 1000     -- wait ms to complete (also whichkey)
vim.opt.splitright = true     -- open new split window on the right
vim.opt.splitbelow = true     -- open new split window below
vim.opt.nrformats = 'alpha,bin,hex,unsigned' -- incr/decr with <C-a> and <C-x>
vim.opt.number = true         -- show number column
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.numberwidth = 5       -- n-1 digits + 1 space
vim.opt.signcolumn = 'yes'
vim.opt.winwidth = 87         -- min cols for current window
vim.opt.list = false          -- show/hide invisible chars
vim.opt.listchars = {
  tab = '▷-',
  space = '·',
  eol = '↲',
  nbsp = '␣',
  trail = '█',
  extends = '→',
  precedes = '←'
				}
vim.opt.formatoptions:append({'n'}) -- indent numbered paragraph
vim.opt.fillchars = { eob = ' ', fold = '―' }
vim.opt.colorcolumn = '80,100'
vim.opt.cursorline = true
vim.opt.scrolloff = 2         -- min additional lines below/above current
vim.opt.sidescrolloff = 1     -- min additional cols left/right current
-- wrapping
vim.opt.wrap = false          -- show long line in multiple lines (softwrap)
vim.opt.textwidth = 0         -- if >0 forces linebreak at given width or less
vim.opt.linebreak = true      -- softwrap at chars defined in 'breakat'
vim.opt.breakindent = true    -- visually indent wrapped lines
vim.opt.showbreak = '┇ '      -- prefix for the softwrapped lines (↪▕ 󱞪│)
vim.opt.whichwrap = 'b,s,<,>,~,[,]'
-- indentation
vim.opt.expandtab = true      -- <tab> expands to spaces in insert mode
vim.opt.shiftround = true     -- round indentation to multiple of shiftwidth
vim.opt.tabstop = 2           -- how many spaces correspond to a tab
vim.opt.shiftwidth = 0        -- indentation spaces, 0 = same as tabstop
vim.opt.softtabstop = 0       -- mix spaces and tabs, 0 = disabled
-- search
vim.opt.ignorecase = true     -- ignore case in search patterns
vim.opt.smartcase = true      -- override ignorecase if there are capitals
-- folding
vim.opt.foldenable = false
vim.opt.foldopen = 'hor,mark,percent,quickfix,search,tag,undo'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()' -- 'v:lua.vim.lsp.foldexpr()'  -- TODO: new version of neovim
vim.opt.foldcolumn = '0'
vim.opt.foldlevelstart = 1
-- vim.opt.foldlevel = 0         -- 0 closes all folds, 99 all open
vim.opt.foldnestmax = 4       -- don't fold past this level (levels 0 to n-1)
-- other
vim.opt.swapfile = true       -- not recommended to disable
vim.opt.virtualedit = { 'block', 'onemore' }
vim.opt.showmode = false      -- disabled because lualine already shows mode
vim.opt.cmdheight = 1
vim.opt.mouse = 'nvc' -- enabled normal,visual,command. disabled in insert mode
vim.opt.startofline = true -- jumps move the cursor to the first nonblank
-- vim.opt.clipboard = 'unnamedplus' -- use system clipboard NOTE: system clipboard is unsafe on xorg
vim.opt.completeopt = 'menu,menuone,noselect' -- completion shows menu with options, none selected
