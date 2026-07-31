-- make :help open in a vertical split
vim.api.nvim_create_autocmd('BufWinEnter', { buffer = 0, command = 'wincmd L' })

