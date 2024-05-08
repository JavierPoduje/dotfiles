-- Git management
vim.keymap.set("n", "<Leader>gl", ":diffget //3<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>gh", ":diffget //2<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>gs", ":G<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>gp", ":GitGutterPreviewHunk<CR>", { silent = true, noremap = true })
