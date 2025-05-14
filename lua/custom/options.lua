vim.opt.nu=true
vim.opt.relativenumber=true
-- Toggle relative line numbers with <leader>ln (line numbers)
vim.keymap.set("n", "<leader>ln", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end)

