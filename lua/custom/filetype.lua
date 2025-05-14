vim.filetype.add({
  pattern = {
    ['^Dockerfile[_%w%-]*$'] = 'dockerfile',
  },
}) 