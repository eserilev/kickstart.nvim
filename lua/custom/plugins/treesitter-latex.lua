-- Keep treesitter away from LaTeX: vimtex's own syntax provides highlighting,
-- conceal, and the mathzone detection that gates the tex snippets. The skip
-- now lives in the FileType autocmd of the nvim-treesitter spec in init.lua
-- (the main branch has no ignore_install/highlight.disable options).
return {}
