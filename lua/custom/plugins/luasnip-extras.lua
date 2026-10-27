-- Extends kickstart's LuaSnip (a blink.cmp dependency) without touching core
-- files: lazy.nvim merges this fragment's opts and my config wins (imported last).
return {
  "L3MON4D3/LuaSnip",
  opts = {
    enable_autosnippets = true,
    -- In visual mode, <Tab> cuts the selection into LS_SELECT_RAW so the next
    -- snippet's get_visual node can wrap it. (store_selection_keys is the
    -- deprecated name for this option.)
    cut_selection_keys = "<Tab>",
  },
  config = function(_, opts)
    local ls = require("luasnip")
    ls.setup(opts)
    require("luasnip.loaders.from_lua").load({
      paths = { vim.fn.stdpath("config") .. "/luasnippets" },
    })
  end,
}
