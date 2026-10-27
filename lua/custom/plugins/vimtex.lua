return {
  "lervag/vimtex",
  lazy = false, -- vimtex handles its own lazy loading; do not lazy-load (per docs)
  init = function()
    -- zathura_simple: the plain "zathura" method needs xdotool window-id
    -- tracking, which is X11-only — we are on Wayland/GNOME.
    vim.g.vimtex_view_method = "zathura_simple"
  end,
}
