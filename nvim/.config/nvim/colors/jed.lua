local colors = {
  -- stylua: ignore start
  cyan               = "#8abeb7",
  dark               = "#1a252f",
  white              = "#fefefe",
  green              = "#99cc99",
  yellow             = "#ebcb8b",
  blue               = "#81a2be",
  sky_blue           = "#8fbcbb",
  turquoise          = "#8abec7",
  orange             = "#c9967a",
  red                = "#bf616a",
  gray               = "#949494",
  light_gray         = "#7f7f7f",
  lighter_gray       = "#6f6e6f",
  brick              = "#875f5f",
  ml_bg              = "#243240",
  ml_git_branch      = "#d9d9d9",

  cyan_light         = "#b3d1cb",
  dark_light         = "#243240",
  white_light        = "#ffffff",
  green_light        = "#b3d9b3",
  yellow_light       = "#f0d49c",
  blue_light         = "#a1b8d1",
  sky_blue_light     = "#b8e6e1",
  turquoise_light    = "#b1d1d8",
  orange_light       = "#ddb195",
  red_light          = "#d19ca3",
  gray_light         = "#b5b5b5",
  light_gray_light   = "#a5a5a5",
  lighter_gray_light = "#8f8e8f",
  brick_light        = "#a5888a",

  cyan_dark          = "#5c8a82",
  dark_dark          = "#0f1a23",
  white_dark         = "#cccccc",
  green_dark         = "#66996e",
  yellow_dark        = "#c7a155",
  blue_dark          = "#5a7a8c",
  sky_blue_dark      = "#6b9a97",
  turquoise_dark     = "#5c8a95",
  orange_dark        = "#a6785f",
  red_dark           = "#9c525a",
  gray_dark          = "#6b6b6b",
  light_gray_dark    = "#555555",
  lighter_gray_dark  = "#4a4a4a",
  brick_dark         = "#5f3f3f",

  lm_cyan            = "#1a8a7a",
  lm_green           = "#3a7a4a",
  lm_yellow          = "#a07820",
  lm_blue            = "#2d5f80",
  lm_sky_blue        = "#2e6e6c",
  lm_turquoise       = "#2a6878",
  lm_orange          = "#8a4a28",
  lm_red             = "#922830",
  lm_gray            = "#606878",
  lm_light_gray      = "#78808e",
  lm_lighter_gray    = "#8a909a",
  lm_brick           = "#7a3030",
  lm_fg              = "#2a3542",
  lm_muted_fg        = "#6a6e7a",
  lm_yellow_light    = "#b8860b",
  lm_visual          = "#b3b6b6",
  lm_cursor_col      = "#f0f0f8",
  lm_color_col       = "#e8e8f0",
  lm_diff_add        = "#d0f0d0",
  lm_diff_del        = "#f0d0d0",
  lm_diff_line_bg    = "#e0e0e8",
  lm_ml_bg           = "#d0d4da",
  lm_ml_fg           = "#2a3542",
  -- stylua: ignore end
}

local light = vim.o.background == "light"
local h = vim.api.nvim_set_hl

-- stylua: ignore start
local c = {
  fn                 = light and colors.lm_sky_blue     or colors.sky_blue_light,
  keyword            = light and colors.lm_fg           or colors.white_dark,
  operator           = light and colors.lm_fg           or colors.white,
  noise              = light and colors.lm_muted_fg     or colors.white_dark,
  diff_text          = light and colors.lm_fg           or colors.white,
  error              = light and colors.lm_red          or colors.red,
  warning            = light and colors.lm_orange       or colors.orange,
  hint               = light and colors.lm_blue         or colors.blue,
  string             = light and colors.lm_green        or colors.green,
  yellow             = light and colors.lm_yellow       or colors.yellow,
  cyan               = light and colors.lm_cyan         or colors.cyan,
  turquoise          = light and colors.lm_turquoise    or colors.turquoise,
  turquoise_light    = light and colors.lm_turquoise    or colors.turquoise_light,
  orange             = light and colors.lm_orange       or colors.orange,
  orange_light       = light and colors.lm_orange       or colors.orange_light,
  orange_dark        = light and colors.lm_orange       or colors.orange_dark,
  blue_light         = light and colors.lm_blue         or colors.blue_light,
  gray               = light and colors.lm_gray         or colors.gray,
  brick              = light and colors.lm_brick        or colors.brick,
  deprecated         = light and colors.lm_brick        or colors.brick,
  mute               = light and colors.lm_lighter_gray or colors.dark_light,
  nontext            = light and colors.lm_light_gray   or colors.gray_light,
  lighter_gray_light = light and colors.lm_light_gray   or colors.lighter_gray_light,

  -- Popup menu
  search_fg          = light and colors.lm_fg           or colors.white,
  pmenu_fg           = light and colors.lm_fg           or colors.white,
  pmenu_sel_bg       = light and colors.lm_light_gray   or colors.gray_dark,
  pmenu_thumb_bg     = light and colors.lm_ml_bg        or colors.dark,

  diff_change_fg     = light and colors.lm_yellow_light or colors.yellow_light,
  visual_bg          = light and colors.lm_visual       or colors.light_gray_dark,
  cursor_col_bg      = light and colors.lm_cursor_col   or colors.lighter_gray_dark,
  color_col_bg       = light and colors.lm_color_col    or colors.dark_light,
  diff_add_bg        = light and colors.lm_diff_add     or colors.light_gray,
  diff_del_bg        = light and colors.lm_diff_del     or colors.brick,
  diff_line_fg       = light and colors.lm_fg           or colors.dark_dark,
  diff_line_bg       = light and colors.lm_diff_line_bg or colors.light_gray_dark,

  ml_bg              = light and colors.lm_ml_bg        or colors.ml_bg,
  ml_fg              = light and colors.lm_ml_fg        or colors.ml_git_branch,
  ml_secondary_fg    = light and colors.lm_muted_fg     or colors.white_light,

  float_bg           = light and colors.lm_ml_bg        or nil,
}

h(0, "Function",                           { fg = c.fn })
h(0, "Keyword",                            { fg = c.keyword,            bold = false })
h(0, "Error",                              { fg = c.error,              italic = true })
h(0, "Warning",                            { fg = c.warning,            italic = true })
h(0, "Hint",                               { fg = c.hint })
h(0, "Special",                            { fg = c.turquoise_light })
h(0, "String",                             { fg = c.string })
h(0, "Search",                             { fg = c.search_fg,          reverse = true })
h(0, "IncSearch",                          { reverse = true })
h(0, "MatchParen",                         {})
h(0, "Type",                               { fg = c.turquoise_light })
h(0, "TypeDef",                            { fg = c.turquoise })
h(0, "Pmenu",                              { fg = c.pmenu_fg })
h(0, "PmenuSel",                           { fg = c.pmenu_fg,           bg = c.pmenu_sel_bg, bold = true })
h(0, "PmenuThumb",                         { fg = c.orange,             bg = c.pmenu_thumb_bg })
h(0, "Operator",                           { fg = c.operator })
h(0, "Visual",                             { bg = c.visual_bg })
h(0, "Conditional",                        { fg = c.yellow,             bold = true })
h(0, "Macro",                              { fg = c.orange_light })
h(0, "Define",                             { fg = c.orange_light,       italic = true })
h(0, "Structure",                          { fg = c.blue_light,         italic = true })
h(0, "Mute",                               { fg = c.mute })

h(0, "Title",                              { fg = c.blue_light,         bold = true })
h(0, "URI",                                {})
h(0, "LineNr",                             { fg = c.gray })

h(0, "Noise",                              { fg = c.noise })
h(0, "NonText",                            { fg = c.nontext,            italic = true })
h(0, "NotNormal",                          { fg = c.turquoise })
h(0, "CursorLineNr",                       { fg = c.yellow })
h(0, "ColorCol",                           { bg = c.color_col_bg })
h(0, "CursorCol",                          { bg = c.cursor_col_bg })
h(0, "Builtin",                            { fg = c.turquoise })
h(0, "NetrwDir",                           { fg = c.turquoise,          bold = true })
h(0, "NormalFloat",                        {})
h(0, "Number",                             { fg = c.yellow,             bold = true })
h(0, "SpecialChar",                        { fg = c.cyan,               italic = true })

h(0, "Directory",                          { fg = c.orange,             bold = true })

h(0, "Tag",                                { fg = c.orange_light,       bold = true })
h(0, "SecondaryTag",                       { fg = c.blue_light,         italic = true })
h(0, "TSMember",                           { fg = c.blue_light }) -- VAL.<target=true}>
h(0, "MDmeta",                             { fg = c.orange_dark })
h(0, "MDlabel",                            { fg = c.turquoise_light,    bold = true })
h(0, "MDlink",                             { fg = c.lighter_gray_light, italic = true })

h(0, "DiffAdd",                            { bg = c.diff_add_bg,        bold = true })
h(0, "DiffAdded",                          { bg = c.diff_add_bg })
h(0, "DiffChange",                         { fg = c.diff_change_fg,     italic = true })
h(0, "DiffDelete",                         { bg = c.diff_del_bg })
h(0, "DiffLine",                           { fg = c.diff_line_fg,       bg = c.diff_line_bg, underline = true })
h(0, "DiffRemoved",                        { bg = c.diff_del_bg })
h(0, "DiffText",                           { fg = c.diff_text })

h(0, "MinLineMode",                        { fg = c.hint,               bg = c.ml_bg,        bold = true })
h(0, "MinLineGitBranch",                   { fg = c.ml_fg,              bg = c.ml_bg,        bold = true })
h(0, "MinLinePrimaryText",                 { fg = c.ml_fg,              bg = c.ml_bg,        bold = true })
h(0, "MinLineSecondaryText",               { fg = c.ml_secondary_fg,    bg = c.ml_bg })

h(0, "Deprecated",                         { fg = c.deprecated,         italic = true })

h(0, "EndOfBuffer",                        { link = "Mute" })
h(0, "Delimiter",                          { link = "NotNormal" })
h(0, "Identifier",                         { link = "Normal" })
h(0, "Statement",                          { link = "NotNormal" })
h(0, "SignColumn",                         { link = "Mute" })
h(0, "FoldColumn",                         { link = "LineNr" })
h(0, "Folded",                             { link = "NonText" })
h(0, "Comment",                            { link = "NonText" })
h(0, "ColorColumn",                        { link = "ColorCol" })
h(0, "PreProc",                            { link = "Macro" })

h(0, "helpHeader",                         { link = "Normal" })
h(0, "helpHeadline",                       { link = "Title" })
h(0, "helpHyperTextEntry",                 { link = "Normal" })
h(0, "helpIgnore",                         { link = "NonText" })
h(0, "helpOption",                         { link = "String" })
h(0, "helpSectionDelim",                   { link = "Noise" })

h(0, "ErrorMsg",                           { link = "Error" })
h(0, "ModeMsg",                            { link = "Normal" })
h(0, "@string.docstring",                  { link = "Comment" })
h(0, "@function.builtin",                  { link = "Builtin" })
h(0, "@namespace",                         { link = "NotNormal" })
h(0, "Whitespace",                         { link = "NonText" })
h(0, "NvimInternalError",                  { link = "Error" })
h(0, "FloatBorder",                        { link = "NonText" })
h(0, "Include",                            { link = "Noise" })
h(0, "Conceal",                            { link = "NonText" })

h(0, "@variable.member.typescript",        { link = "TSMember" })
h(0, "@keyword.directive.markdown",        { link = "MDmeta" })
h(0, "@markup.link.label.markdown_inline", { link = "MDlabel" })
h(0, "@markup.link.markdown_inline",       { link = "URI" })
h(0, "@markup.link.url.markdown_inline",   { link = "MDlink" })

h(0, "@comment.error",                     { link = "DiagnosticError" })
h(0, "@comment.warning",                   { link = "DiagnosticWarn" })
h(0, "@comment.todo",                      { link = "DiagnosticInfo" })

h(0, "@lsp.type.macro.rust",               { link = "Macro" })
h(0, "@lsp.type.enumMember.rust",          { link = "Special" })

h(0, "@keyword.function.odin",             { link = "Function" })

h(0, "BlinkCmpMenu",                       { link = "Pmenu" })
h(0, "BlinkCmpMenuBorder",                 { link = "Pmenu" })
h(0, "BlinkCmpMenuSelection",              { link = "PmenuSel" })
h(0, "BlinkCmpScrollBarThumb",             { link = "PmenuThumb" })
h(0, "BlinkCmpLabelDeprecated",            { link = "Deprecated" })

h(0, "Normal",                             { bg = "none" })
h(0, "NormalFloat",                        { bg = c.float_bg })
-- stylua: ignore end
