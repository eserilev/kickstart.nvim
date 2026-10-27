return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git diff (changed files)" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git history (this file)" },
    { "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Git diff close" },
  },
}
