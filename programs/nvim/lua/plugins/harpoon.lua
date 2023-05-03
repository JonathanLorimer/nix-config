require("harpoon").setup()
require("telescope").load_extension('harpoon')

vim.api.nvim_set_keymap('n', '<leader>ma', ":lua require('harpoon.mark').add_file()<CR>", { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>mm', ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>mj', ":lua require('harpoon.ui').nav_next()<CR>", { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>mk', ":lua require('harpoon.ui').nav_prev()<CR>", { noremap = true})
