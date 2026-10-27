-- Inline Jupyter cells + plots for 20425 simulations.
-- Kernel: "study" -> ~/study/.venv (pynvim, jupyter_client, ipykernel,
-- matplotlib). Start with :MoltenInit study.
return {
  {
    "3rd/image.nvim",
    -- Pinned: image.nvim breaks more often than most plugins (molten's advice).
    version = "1.*",
    opts = {
      backend = "kitty", -- Ghostty implements the kitty graphics protocol
      processor = "magick_cli", -- system imagemagick, no luarocks needed
    },
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- nvim's python provider must live where pynvim/jupyter_client are
      vim.g.python3_host_prog = vim.fn.expand("~/study/.venv/bin/python")
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_virt_text_output = true
      vim.g.molten_auto_open_output = false
    end,
  },
}
