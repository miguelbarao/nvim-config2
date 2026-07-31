-- NOTE: currently uninstalled/disabled
return {
  cmd = { 'asm-lsp' },
  filetypes = { 'asm', 'vmasm' },
  -- root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    instruction_set = 'riscv',
    assembler = 'mars',
  },
}
