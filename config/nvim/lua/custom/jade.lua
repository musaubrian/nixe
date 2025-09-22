local ncolors = {
  { name = "cyan", light = "", color = "", dark = "" },
}

local colors = {
  -- Base colors
  cyan = "#8abeb7",
  dark = "#171717",
  white = "#fefefe",
  green = "#99cc99",
  yellow = "#f0c674",
  blue = "#81a2be",
  sky_blue = "#7bdaf7",
  turquoise = "#8abec7",
  orange = "#d7875f",
  red = "#cc6666",
  gray = "#949494",
  light_gray = "#7f7f7f",
  lighter_gray = "#6f6e6f",
  brick = "#875f5f",
  ml_bg = "#2e2e2e",
  ml_git_branch = "#d9d9d9",

  -- Light variants
  cyan_light = "#b3d1cb",
  dark_light = "#2a2a2a",
  white_light = "#ffffff",
  green_light = "#b3d9b3",
  yellow_light = "#f4d4a7",
  blue_light = "#a1b8d1",
  sky_blue_light = "#9ee5f9",
  turquoise_light = "#b1d1d8",
  orange_light = "#e5a188",
  red_light = "#d99999",
  gray_light = "#b5b5b5",
  light_gray_light = "#a5a5a5",
  lighter_gray_light = "#8f8e8f",
  brick_light = "#a5888a",

  -- Dark variants
  cyan_dark = "#5c8a82",
  dark_dark = "#0a0a0a",
  white_dark = "#cccccc",
  green_dark = "#66996e",
  yellow_dark = "#c7a042",
  blue_dark = "#5a7a8c",
  sky_blue_dark = "#4db0c5",
  turquoise_dark = "#5c8a95",
  orange_dark = "#a5632d",
  red_dark = "#994d4d",
  gray_dark = "#6b6b6b",
  light_gray_dark = "#555555",
  lighter_gray_dark = "#4a4a4a",
  brick_dark = "#5f3f3f",
}

vim.api.nvim_set_hl(0, "Function", { fg = colors.sky_blue_light, bg = nil })
vim.api.nvim_set_hl(0, "Keyword", { fg = colors.white, bg = nil, bold = true })
vim.api.nvim_set_hl(0, "Error", { fg = colors.red, bg = nil, italic = true })
vim.api.nvim_set_hl(0, "Warning", { fg = colors.orange, bg = nil, italic = true })
vim.api.nvim_set_hl(0, "Hint", { fg = colors.blue, bg = nil })
vim.api.nvim_set_hl(0, "Special", { fg = colors.turquoise_light, bg = nil })
vim.api.nvim_set_hl(0, "String", { fg = colors.green, bg = nil })
vim.api.nvim_set_hl(0, "Search", { fg = colors.white, bg = nil, reverse = true })
vim.api.nvim_set_hl(0, "IncSearch", { fg = nil, bg = nil, reverse = true })
vim.api.nvim_set_hl(0, "MatchParen", { fg = nil, bg = nil })
vim.api.nvim_set_hl(0, "Type", { fg = colors.turquoise_light, bg = nil })
vim.api.nvim_set_hl(0, "TypeDef", { fg = colors.turquoise, bg = nil })
vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.white, bg = nil })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.white, bg = colors.gray_dark, bold = true })
vim.api.nvim_set_hl(0, "PmenuThumb", { fg = colors.orange, bg = colors.dark })
vim.api.nvim_set_hl(0, "Operator", { fg = colors.white, bg = nil })
vim.api.nvim_set_hl(0, "Visual", { fg = nil, bg = colors.light_gray_dark })
vim.api.nvim_set_hl(0, "Conditional", { fg = colors.yellow, bg = nil, bold = true })
vim.api.nvim_set_hl(0, "Macro", { fg = colors.orange_light, bg = nil })
vim.api.nvim_set_hl(0, "Define", { fg = colors.orange_light, bg = nil, italic = true })
vim.api.nvim_set_hl(0, "Structure", { fg = colors.blue_light, bg = nil, italic = true })
vim.api.nvim_set_hl(0, "Mute", { fg = colors.dark_light, bg = nil })

vim.api.nvim_set_hl(0, "Title", { fg = colors.blue_light, bg = nil, bold = true })
vim.api.nvim_set_hl(0, "URI", { fg = nil, bg = nil })
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.gray, bg = nil })

vim.api.nvim_set_hl(0, "Noise", { fg = colors.white_dark, bg = nil })
vim.api.nvim_set_hl(0, "NonText", { fg = colors.gray_light, bg = nil, italic = true })
vim.api.nvim_set_hl(0, "NotNormal", { fg = colors.turquoise, bg = nil })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.yellow, bg = nil })
vim.api.nvim_set_hl(0, "ColorCol", { fg = nil, bg = colors.dark_light })
vim.api.nvim_set_hl(0, "CursorCol", { fg = nil, bg = colors.lighter_gray_dark })
vim.api.nvim_set_hl(0, "Builtin", { fg = colors.turquoise, bg = nil })
vim.api.nvim_set_hl(0, "NetrwDir", { fg = colors.turquoise, bg = nil, bold = true })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = nil, bg = nil })
vim.api.nvim_set_hl(0, "Number", { fg = colors.yellow, bg = nil, bold = true })
vim.api.nvim_set_hl(0, "SpecialChar", { fg = colors.cyan, bg = nil, italic = true })

vim.api.nvim_set_hl(0, "Directory", { fg = colors.orange_light, bg = nil, bold = true })

vim.api.nvim_set_hl(0, "Tag", { fg = colors.orange_light, bg = nil, bold = true })
vim.api.nvim_set_hl(0, "SecondaryTag", { fg = colors.blue_light, bg = nil, italic = true })
vim.api.nvim_set_hl(0, "TSMember", { fg = colors.blue_light, bg = nil, nil }) -- VAL.<target=true}>
vim.api.nvim_set_hl(0, "MDmeta", { fg = colors.orange_dark, bg = nil })
vim.api.nvim_set_hl(0, "MDlabel", { fg = colors.turquoise_light, bg = nil, bold = true })
vim.api.nvim_set_hl(0, "MDlink", { fg = colors.lighter_gray_light, bg = nil, italic = true })

vim.api.nvim_set_hl(0, "DiffAdd", { fg = nil, bg = colors.light_gray, bold = true })
vim.api.nvim_set_hl(0, "DiffAdded", { fg = nil, bg = colors.light_gray })
vim.api.nvim_set_hl(0, "DiffChange", { fg = colors.yellow_light, bg = nil, italic = true })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = nil, bg = colors.brick })
vim.api.nvim_set_hl(0, "DiffLine", { fg = colors.dark_dark, bg = colors.light_gray_dark, underline = true })
vim.api.nvim_set_hl(0, "DiffRemoved", { fg = nil, bg = colors.brick })
vim.api.nvim_set_hl(0, "DiffText", { fg = colors.white, bg = nil })

vim.api.nvim_set_hl(0, "MinLineMode", { fg = colors.blue, bg = colors.ml_bg, bold = true })
vim.api.nvim_set_hl(0, "MinLineGitBranch", { fg = colors.ml_git_branch, bg = colors.ml_bg, bold = true })
vim.api.nvim_set_hl(0, "MinLinePrimaryText", { fg = colors.white, bg = colors.ml_bg, bold = true })
vim.api.nvim_set_hl(0, "MinLineSecondaryText", { fg = colors.white_light, bg = colors.ml_bg })

vim.api.nvim_set_hl(0, "Deprecated", { fg = colors.brick, bg = nil, italic = true })

vim.api.nvim_set_hl(0, "EndOfBuffer", { link = "Mute" })
vim.api.nvim_set_hl(0, "Delimiter", { link = "NotNormal" })
vim.api.nvim_set_hl(0, "Identifier", { link = "Normal" })
vim.api.nvim_set_hl(0, "Statement", { link = "NotNormal" })
vim.api.nvim_set_hl(0, "SignColumn", { link = "Mute" })
vim.api.nvim_set_hl(0, "FoldColumn", { link = "LineNr" })
vim.api.nvim_set_hl(0, "Folded", { link = "NonText" })
vim.api.nvim_set_hl(0, "Comment", { link = "NonText" })
vim.api.nvim_set_hl(0, "ColorColumn", { link = "ColorCol" })
vim.api.nvim_set_hl(0, "PreProc", { link = "Macro" })

vim.api.nvim_set_hl(0, "helpHeader", { link = "Normal" })
vim.api.nvim_set_hl(0, "helpHeadline", { link = "Title" })
vim.api.nvim_set_hl(0, "helpHyperTextEntry", { link = "Normal" })
vim.api.nvim_set_hl(0, "helpIgnore", { link = "NonText" })
vim.api.nvim_set_hl(0, "helpOption", { link = "String" })
vim.api.nvim_set_hl(0, "helpSectionDelim", { link = "Noise" })

vim.api.nvim_set_hl(0, "ErrorMsg", { link = "Error" })
vim.api.nvim_set_hl(0, "ModeMsg", { link = "Normal" })
vim.api.nvim_set_hl(0, "CursorLineNr", { link = "CursorLineNr" })
vim.api.nvim_set_hl(0, "@string.docstring", { link = "Comment" })
vim.api.nvim_set_hl(0, "@function.builtin", { link = "Builtin" })
vim.api.nvim_set_hl(0, "@namespace", { link = "NotNormal" })
vim.api.nvim_set_hl(0, "Whitespace", { link = "NonText" })
vim.api.nvim_set_hl(0, "NvimInternalError", { link = "Error" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "NonText" })
vim.api.nvim_set_hl(0, "Include", { link = "Noise" }) --imports and stuff
vim.api.nvim_set_hl(0, "NetrwDir", { link = "NetrwDir" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "NormalFloat" }) --remove bg from floating windows
vim.api.nvim_set_hl(0, "Conceal", { link = "NonText" })
vim.api.nvim_set_hl(0, "@tag.vue", { link = "Tag" })
vim.api.nvim_set_hl(0, "@tag.attribute.vue", { link = "SecondaryTag" })
vim.api.nvim_set_hl(0, "@variable.member.vue", { link = "SecondaryTag" }) -- :<attribute>
vim.api.nvim_set_hl(0, "@variable.member.typescript", { link = "TSMember" })
vim.api.nvim_set_hl(0, "@keyword.directive.markdown", { link = "MDmeta" })
vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { link = "MDlabel" })
vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { link = "URI" })
vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { link = "MDlink" })

vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "Pmenu" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })
vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", { link = "PmenuThumb" })
vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { link = "Deprecated" })

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
