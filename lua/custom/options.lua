vim.opt.nu=true
vim.opt.relativenumber=true
-- Toggle relative line numbers with <leader>ln (line numbers)
vim.keymap.set("n", "<leader>ln", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end)

-- Set up highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end
})

-- Create a highlight group for matches
vim.api.nvim_set_hl(0, 'VisualMatches', { bg = '#4c4c4c', fg = 'NONE' })

-- Function to get visual selection
local function get_visual_selection()
  local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
  local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))
  
  -- Adjust for multibyte chars
  start_col = vim.fn.byteidx(vim.fn.getline(start_line), start_col - 1) + 1
  end_col = vim.fn.byteidx(vim.fn.getline(end_line), end_col - 1) + 1
  
  -- Get text from selection
  if start_line == end_line then
    local line = vim.fn.getline(start_line)
    return string.sub(line, start_col, end_col)
  end
  return ""
end

-- Highlight matching text when mode changes
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*:v,*:V',
  callback = function()
    -- Clear any existing matches when entering visual mode
    vim.fn.clearmatches()
  end
})

-- Highlight matches after selection
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = 'v:n,V:n',
  callback = function()
    local selected_text = get_visual_selection()
    if selected_text and selected_text ~= "" then
      -- Clear existing matches
      vim.fn.clearmatches()
      -- Add new matches with a subtle highlight
      vim.fn.matchadd('VisualMatches', vim.fn.escape(selected_text, '\\/.^$*[]'), -1)
    end
  end
})

-- Key mapping to clear highlights
vim.keymap.set('n', '<Esc>', function()
  vim.fn.clearmatches()
  -- Call the normal Esc behavior
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
end, { noremap = true })

