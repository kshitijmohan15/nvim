vim.g.mapleader = " " 

-- Terminal mode mappings
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { desc = 'Exit terminal mode (Option 1)' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode (Option 2)' })

vim.keymap.set("n", "<leader>pv", function()
  local current_file = vim.fn.expand('%:p')
  local current_dir
  
  if current_file ~= '' then
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  else
    current_dir = vim.fn.getcwd()
  end
  
  require("oil").open(current_dir)
end, { desc = "Open directory in current buffer" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


