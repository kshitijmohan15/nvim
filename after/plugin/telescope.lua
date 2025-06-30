require("telescope").setup({
    pickers = {
        find_files = {
            theme = "dropdown",
        },
    },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})

vim.keymap.set("v", "<leader>ps", function()
	vim.cmd('noau normal! "vy"')
	local selected_text = vim.fn.getreg('v')
	builtin.live_grep({ default_text = selected_text })
end)
