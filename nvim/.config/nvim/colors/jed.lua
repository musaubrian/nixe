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
  -- stylua: ignore end
}

--- @param name string
--- @param val vim.api.keyset.highlight
local function h(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

-- stylua: ignore start
local c = {
  fn                 = colors.sky_blue_light,
  keyword            = colors.white_dark,
  operator           = colors.white,
  noise              = colors.white_dark,
  diff_text          = colors.white,
  error              = colors.red,
  warning            = colors.orange,
  hint               = colors.blue,
  string             = colors.green,
  yellow             = colors.yellow,
  cyan               = colors.cyan,
  turquoise          = colors.turquoise,
  turquoise_light    = colors.turquoise_light,
  orange             = colors.orange,
  orange_light       = colors.orange_light,
  orange_dark        = colors.orange_dark,
  blue_light         = colors.blue_light,
  gray               = colors.gray,
  brick              = colors.brick,
  deprecated         = colors.brick,
  mute               = colors.dark_light,
  nontext            = colors.gray_light,
  lighter_gray_light = colors.lighter_gray_light,

  -- Popup menu
  search_fg          = colors.white,
  pmenu_fg           = colors.white,
  pmenu_sel_bg       = colors.gray_dark,
  pmenu_thumb_bg     = colors.dark,

  diff_change_fg     = colors.yellow_light,
  visual_bg          = colors.light_gray_dark,
  cursor_col_bg      = colors.lighter_gray_dark,
  color_col_bg       = colors.dark_light,
  diff_add_bg        = colors.light_gray,
  diff_del_bg        = colors.brick,
  diff_line_fg       = colors.dark_dark,
  diff_line_bg       = colors.light_gray_dark,

  ml_bg              = colors.ml_bg,
  ml_fg              = colors.ml_git_branch,
  ml_secondary_fg    = colors.white_light,

  float_bg           = nil,
}

h("Function",                           { fg = c.fn })
h("Keyword",                            { fg = c.keyword,            bold = false })
h("Error",                              { fg = c.error,              italic = true })
h("Warning",                            { fg = c.warning,            italic = true })
h("Hint",                               { fg = c.hint })
h("Special",                            { fg = c.turquoise_light })
h("String",                             { fg = c.string })
h("Search",                             { fg = c.search_fg,          reverse = true })
h("IncSearch",                          { reverse = true })
h("MatchParen",                         {})
h("Type",                               { fg = c.turquoise_light })
h("TypeDef",                            { fg = c.turquoise })
h("Pmenu",                              { fg = c.pmenu_fg })
h("PmenuSel",                           { fg = c.pmenu_fg,           bg = c.pmenu_sel_bg, bold = true })
h("PmenuThumb",                         { fg = c.orange,             bg = c.pmenu_thumb_bg })
h("Operator",                           { fg = c.operator })
h("Visual",                             { bg = c.visual_bg })
h("Conditional",                        { fg = c.yellow,             bold = true })
h("Macro",                              { fg = c.orange_light })
h("Define",                             { fg = c.orange_light,       italic = true })
h("Structure",                          { fg = c.blue_light,         italic = true })
h("Mute",                               { fg = c.mute })

h("Title",                              { fg = c.blue_light,         bold = true })
h("URI",                                {})
h("LineNr",                             { fg = c.gray })

h("Noise",                              { fg = c.noise })
h("NonText",                            { fg = c.nontext,            italic = true })
h("NotNormal",                          { fg = c.turquoise })
h("CursorLineNr",                       { fg = c.yellow })
h("ColorCol",                           { bg = c.color_col_bg })
h("CursorCol",                          { bg = c.cursor_col_bg })
h("Builtin",                            { fg = c.turquoise })
h("NetrwDir",                           { fg = c.turquoise,          bold = true })
h("NormalFloat",                        {})
h("Number",                             { fg = c.yellow,             bold = true })
h("SpecialChar",                        { fg = c.cyan,               italic = true })

h("Directory",                          { fg = c.orange,             bold = true })

h("Tag",                                { fg = c.orange_light,       bold = true })
h("SecondaryTag",                       { fg = c.blue_light,         italic = true })
h("TSMember",                           { fg = c.blue_light })
h("MDmeta",                             { fg = c.orange_dark })
h("MDlabel",                            { fg = c.turquoise_light,    bold = true })
h("MDlink",                             { fg = c.lighter_gray_light, italic = true })

h("DiffAdd",                            { bg = c.diff_add_bg,        bold = true })
h("DiffAdded",                          { bg = c.diff_add_bg })
h("DiffChange",                         { fg = c.diff_change_fg,     italic = true })
h("DiffDelete",                         { bg = c.diff_del_bg })
h("DiffLine",                           { fg = c.diff_line_fg,       bg = c.diff_line_bg, underline = true })
h("DiffRemoved",                        { bg = c.diff_del_bg })
h("DiffText",                           { fg = c.diff_text })

h("MinLineMode",                        { fg = c.hint,               bg = c.ml_bg,        bold = true })
h("MinLineGitBranch",                   { fg = c.ml_fg,              bg = c.ml_bg,        bold = true })
h("MinLinePrimaryText",                 { fg = c.ml_fg,              bg = c.ml_bg,        bold = true })
h("MinLineSecondaryText",               { fg = c.ml_secondary_fg,    bg = c.ml_bg })

h("Deprecated",                         { fg = c.deprecated,         italic = true })

h("TodoComment",                        { fg = c.orange_light,  italic = true, bold = true })
h("TodoWarn",                           { fg = c.orange_light,  italic = true, bold = true })

h("EndOfBuffer",                        { link = "Mute" })
h("Delimiter",                          { link = "NotNormal" })
h("Identifier",                         { link = "Normal" })
h("Statement",                          { link = "NotNormal" })
h("SignColumn",                         { link = "Mute" })
h("FoldColumn",                         { link = "LineNr" })
h("Folded",                             { link = "NonText" })
h("Comment",                            { link = "NonText" })
h("ColorColumn",                        { link = "ColorCol" })
h("PreProc",                            { link = "Macro" })

h("helpHeader",                         { link = "Normal" })
h("helpHeadline",                       { link = "Title" })
h("helpHyperTextEntry",                 { link = "Normal" })
h("helpIgnore",                         { link = "NonText" })
h("helpOption",                         { link = "String" })
h("helpSectionDelim",                   { link = "Noise" })

h("ErrorMsg",                           { link = "Error" })
h("ModeMsg",                            { link = "Normal" })
h("@string.docstring",                  { link = "Comment" })
h("@function.builtin",                  { link = "Builtin" })
h("@namespace",                         { link = "NotNormal" })
h("Whitespace",                         { link = "NonText" })
h("NvimInternalError",                  { link = "Error" })
h("FloatBorder",                        { link = "NonText" })
h("Include",                            { link = "Noise" })
h("Conceal",                            { link = "NonText" })

h("@variable.member.typescript",        { link = "TSMember" })
h("@keyword.directive.markdown",        { link = "MDmeta" })
h("@markup.link.label.markdown_inline", { link = "MDlabel" })
h("@markup.link.markdown_inline",       { link = "URI" })
h("@markup.link.url.markdown_inline",   { link = "MDlink" })

h("@build_tag",                         { link = "Macro" })

h("@comment.error",                     { link = "DiagnosticError" })
h("@comment.warning",                   { link = "TodoComment" })
h("@comment.todo",                      { link = "TodoWarn" })

h("@lsp.type.macro.rust",               { link = "Macro" })
h("@lsp.typemod.derive.macro.rust",     { link = "Macro" })
h("@lsp.type.enumMember.rust",          { link = "Special" })

h("@keyword.function.odin",             { link = "Function" })

h("BlinkCmpMenu",                       { link = "Pmenu" })
h("BlinkCmpMenuBorder",                 { link = "Pmenu" })
h("BlinkCmpMenuSelection",              { link = "PmenuSel" })
h("BlinkCmpScrollBarThumb",             { link = "PmenuThumb" })
h("BlinkCmpLabelDeprecated",            { link = "Deprecated" })

h("Normal",                             { bg = "none" })
h("NormalFloat",                        { bg = c.float_bg })

-- stylua: ignore end
