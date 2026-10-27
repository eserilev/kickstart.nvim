-- Math snippets for 20218 (ODE) and 20425 (Probability).
-- All are autosnippets; math-mode ones are gated on vimtex's syntax detection
-- so triggers never fire in prose.

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta

-- Mode detection via vimtex
local tex = {}
tex.in_mathzone = function() return vim.fn["vimtex#syntax#in_mathzone"]() == 1 end
tex.in_comment = function() return vim.fn["vimtex#syntax#in_comment"]() == 1 end
tex.in_text = function() return not tex.in_mathzone() and not tex.in_comment() end

-- Visual-selection placeholder: select text, hit <Tab> (cut_selection_keys),
-- then type a trigger — the selection lands in this node.
local function get_visual(_, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  end
  return sn(nil, i(1))
end

-- Helpers: auto-snippet in math zone / in text
local function am(trig, nodes, opts)
  opts = opts or {}
  opts.condition = tex.in_mathzone
  local props = { trig = trig, snippetType = "autosnippet" }
  if opts.wordTrig ~= nil then props.wordTrig = opts.wordTrig; opts.wordTrig = nil end
  if opts.regTrig then props.regTrig = true; opts.regTrig = nil end
  return s(props, nodes, opts)
end
local function at(trig, nodes, opts)
  opts = opts or {}
  opts.condition = tex.in_text
  return s({ trig = trig, snippetType = "autosnippet" }, nodes, opts)
end

-- Greek letters: ";x" -> \<letter>. Unmapped letters expand back to themselves.
local greek = {
  a = "alpha", b = "beta", g = "gamma", d = "delta", e = "varepsilon",
  z = "zeta", h = "eta", q = "theta", i = "iota", k = "kappa",
  l = "lambda", m = "mu", n = "nu", x = "xi", p = "pi", r = "rho",
  s = "sigma", t = "tau", u = "upsilon", f = "phi", c = "chi",
  y = "psi", w = "omega",
  G = "Gamma", D = "Delta", Q = "Theta", L = "Lambda", X = "Xi",
  P = "Pi", S = "Sigma", U = "Upsilon", F = "Phi", Y = "Psi", W = "Omega",
  E = "epsilon", -- ;e is \varepsilon, ;E is \epsilon
}

return {
  -- ======== Delimiters / structure ========
  at("mk", fmta("$<>$", { d(1, get_visual) })),
  at("dm", fmta("\\[\n\t<>\n\\]", { d(1, get_visual) })),
  am("ff", fmta("\\frac{<>}{<>}", { d(1, get_visual), i(2) })),
  am("sq", fmta("\\sqrt{<>}", { d(1, get_visual) })),
  am("td", fmta("^{<>}", { i(1) }), { wordTrig = false }),
  am("__", fmta("_{<>}", { i(1) }), { wordTrig = false }),
  am("lr(", fmta("\\left( <> \\right)", { d(1, get_visual) }), { wordTrig = false }),
  am("lr[", fmta("\\left[ <> \\right]", { d(1, get_visual) }), { wordTrig = false }),
  am("lr{", fmta("\\left\\{ <> \\right\\}", { d(1, get_visual) }), { wordTrig = false }),

  -- ======== ODE (20218) ========
  am("dv", fmta("\\frac{\\dd <>}{\\dd <>}", { i(1, "y"), i(2, "x") })),
  am("pv", fmta("\\frac{\\partial <>}{\\partial <>}", { i(1), i(2) })),
  am("ddx", fmta("\\frac{\\dd}{\\dd <>}", { i(1, "x") })),
  am("int", fmta("\\int <> \\dd <>", { d(1, get_visual), i(2, "x") })),
  am("dint", fmta("\\int_{<>}^{<>} <> \\dd <>", { i(1, "0"), i(2, "\\infty"), d(3, get_visual), i(4, "x") })),
  am("lim", fmta("\\lim_{<> \\to <>}", { i(1, "n"), i(2, "\\infty") })),
  am("sum", fmta("\\sum_{<>}^{<>}", { i(1, "n=1"), i(2, "\\infty") })),

  -- ======== Probability (20425) ========
  am("PP", fmta("\\mathbb{P}(<>)", { d(1, get_visual) })),
  am("EE", fmta("\\mathbb{E}[<>]", { d(1, get_visual) })),
  am("Var", fmta("\\mathrm{Var}(<>)", { d(1, get_visual) })),
  am("Cov", fmta("\\mathrm{Cov}(<>, <>)", { i(1), i(2) })),
  am("sim", t("\\sim ")),
  am("giv", t("\\mid ")),

  -- ======== Greek: ";x" prefix ========
  am(";(%a)", f(function(_, snip)
    local letter = snip.captures[1]
    return greek[letter] and ("\\" .. greek[letter]) or (";" .. letter)
  end), { regTrig = true, wordTrig = false }),

  -- ======== Environments ========
  at("thm", fmta("\\begin{theorem}\n\t<>\n\\end{theorem}", { i(1) })),
  at("dfn", fmta("\\begin{definition}\n\t<>\n\\end{definition}", { i(1) })),
  at("prf", fmta("\\begin{proof}\n\t<>\n\\end{proof}", { i(1) })),
  at("ali", fmta("\\begin{align*}\n\t<>\n\\end{align*}", { d(1, get_visual) })),
  am("pmat", fmta("\\begin{pmatrix} <> \\end{pmatrix}", { i(1) })),
  am("bmat", fmta("\\begin{bmatrix} <> \\end{bmatrix}", { i(1) })),
}
