-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
local vertical_g_map = function(direction)
  if vim.v.count == 0 and vim.fn.mode() ~= 'V' then
    return 'g' .. direction
  else
    return direction
  end
end
vim.keymap.set({ 'n', 'x' }, 'k',
  function()
    return vertical_g_map('k')
  end, { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'j',
  function()
    return vertical_g_map('j')
  end, { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set up the keymap for \cl to toggle conceallevel
vim.keymap.set('n', '<leader>cl',
  function()
    local current_value = vim.wo.conceallevel or 0
    vim.wo.conceallevel = current_value == 2 and 0 or 2
  end,
  { noremap = true, silent = true }
)

-- Set up the keymap for \rl to toggle relative line numbers
vim.keymap.set('n', '<leader>rl',
  function()
    vim.wo.relativenumber = not vim.wo.relativenumber
  end,
  { noremap = true, silent = true }
)

-- Keymap for M-/ to toggle line wrap
vim.keymap.set({ 'n', 'v', 'i' }, '<M-/>',
  function()
    vim.o.wrap = not vim.o.wrap
  end,
  { noremap = true, silent = true }
)
-- vim: ts=2 sts=2 sw=2 et
