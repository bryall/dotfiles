vim.api.nvim_command('set termguicolors')

local Color, colors, Group, groups, styles = require('colorbuddy').setup()

-- gruvbox color palette
local palette = {
  dark0_hard = "#1d2021",
  dark0 = "#282828",
  dark0_soft = "#32302f",
  dark1 = "#3c3836",
  dark2 = "#504945",
  dark3 = "#665c54",
  dark4 = "#7c6f64",
  light0_hard = "#f9f5d7",
  light0 = "#fbf1c7",
  light0_soft = "#f2e5bc",
  light1 = "#ebdbb2",
  light2 = "#d5c4a1",
  light3 = "#bdae93",
  light4 = "#a89984",
  bright_red = "#fb4934",
  bright_green = "#b8bb26",
  bright_yellow = "#fabd2f",
  bright_blue = "#83a598",
  bright_purple = "#d3869b",
  bright_aqua = "#8ec07c",
  bright_orange = "#fe8019",
  neutral_red = "#cc241d",
  neutral_green = "#98971a",
  neutral_yellow = "#d79921",
  neutral_blue = "#458588",
  neutral_purple = "#b16286",
  neutral_aqua = "#689d6a",
  neutral_orange = "#d65d0e",
  faded_red = "#9d0006",
  faded_green = "#79740e",
  faded_yellow = "#b57614",
  faded_blue = "#076678",
  faded_purple = "#8f3f71",
  faded_aqua = "#427b58",
  faded_orange = "#af3a03",
  gray = "#928374",
}

for k, item in pairs(palette) do
  Color.new(k, item)
end

-- options (dark mode by default)
local bg0 = colors.dark0
local bg1 = colors.dark1
local bg2 = colors.dark2
local bg3 = colors.dark3
local bg4 = colors.dark4

local fg0 = colors.light0
local fg1 = colors.light1
local fg2 = colors.light2
local fg3 = colors.light3
local fg4 = colors.light4

local red = colors.bright_red
local green = colors.bright_green
local yellow = colors.bright_yellow
local blue = colors.bright_blue
local purple = colors.bright_purple
local aqua = colors.bright_aqua
local orange = colors.bright_orange
local sign_column = bg1

-- global settings
local settings = {
    bg = "dark",
    contrast_dark = "hard",
    contrart_light = "medium",
    bold = true,
    italic = true,
    undercurl = true,
    underline = true,
    inverse = true,
    improved_strings = false,
    improved_warnings = false,
    invert = false,
    invert_signs = false,
    invert_selection = true,
    invert_tabline = false,
    italicize_comments = true,
    italicize_strings = false,
}

-- setting default values
for k, val in pairs(settings) do
  local key = "gruvbox_" .. k
  if vim.g[key] == nil then
    vim.g[key] = val
  end
end

-- handle light/dark contrast settings
--local bg = vim.o.background
local bg = settings.bg
local contrast = vim.g["gruvbox_contrast_" .. bg]
if contrast == "hard" then
  bg0 = colors[bg .. "0_hard"]
elseif contrast == "soft" then
  bg0 = colors[bg .. "0_soft"]
end

-- swap colors if light mode
if bg == "light" then
  bg0 = colors.light0
  bg1 = colors.light1
  bg2 = colors.light2
  bg3 = colors.light3
  bg4 = colors.light4

  fg0 = colors.dark0
  fg1 = colors.dark1
  fg2 = colors.dark2
  fg3 = colors.dark3
  fg4 = colors.dark4

  red = colors.faded_red
  green = colors.faded_green
  yellow = colors.faded_yellow
  blue = colors.faded_blue
  purple = colors.faded_purple
  aqua = colors.faded_aqua
  orange = colors.faded_orange
end

local hls_cursor = orange
if vim.g.gruvbox_hls_cursor ~= nil then
  hls_cursor = colors[vim.g.gruvbox_hls_cursor]
end

local hls_highlight = yellow
if vim.g.gruvbox_hls_cursor ~= nil then
  hls_cursor = colors[vim.g.gruvbox_hls_highlight]
end

local number_column
if vim.g.gruvbox_number_column ~= nil then
  number_column = colors[vim.g.gruvbox_number_column]
end

local color_column = bg1
if vim.g.gruvbox_color_column ~= nil then
  color_column = colors[vim.g.gruvbox_color_column]
end

local vert_split = bg0
if vim.g.gruvbox_vert_split ~= nil then
  vert_split = colors[vim.g.gruvbox_vert_split]
end

local invert_signs
if vim.g.gruvbox_invert_signs then
  invert_signs = styles.inverse
end

local invert_selection = styles.inverse
if not vim.g.gruvbox_invert_selection then
  invert_selection = nil
end

local invert_tabline
if vim.g.gruvbox_invert_tabline then
  invert_tabline = styles.inverse
end

local tabline_sel = green
if vim.g.gruvbox_tabline_sel then
  tabline_sel = colors[vim.g.gruvbox_tabline_sel]
end

local italic_comments = styles.italic
if not vim.g.gruvbox_italicize_comments then
  italic_comments = nil
end

local italic_strings
if vim.g.gruvbox_italicize_strings then
  italic_strings = styles.italic
end

-- foregrounds
Group.new("GruvboxGray", colors.gray)
Group.new("GruvboxFg0", fg0)
Group.new("GruvboxFg1", fg1)
Group.new("GruvboxFg2", fg2)
Group.new("GruvboxFg3", fg3)
Group.new("GruvboxFg4", fg4)
Group.new("GruvboxGray", colors.gray)

-- backgrounds
Group.new("GruvboxBg0", bg0)
Group.new("GruvboxBg1", bg1)
Group.new("GruvboxBg2", bg2)
Group.new("GruvboxBg3", bg3)
Group.new("GruvboxBg4", bg4)

-- color groups
Group.new("GruvboxAqua", aqua)
Group.new("GruvboxAquaBold", aqua, nil, styles.bold)
Group.new("GruvboxBlue", blue)
Group.new("GruvboxBlueBold", blue, nil, styles.bold)
Group.new("GruvboxGreen", green)
Group.new("GruvboxGreenBold", green, nil, styles.bold)
Group.new("GruvboxOrange", orange)
Group.new("GruvboxOrangeBold", orange, nil, styles.bold)
Group.new("GruvboxPurple", purple)
Group.new("GruvboxPurpleBold", purple, nil, styles.bold)
Group.new("GruvboxRed", red)
Group.new("GruvboxRedBold", red, nil, styles.bold)
Group.new("GruvboxYellow", yellow)
Group.new("GruvboxYellowBold", yellow, nil, styles.bold)

-- signs
Group.new("GruvboxAquaSign", aqua, sign_column, invert_signs)
Group.new("GruvboxBlueSign", blue, sign_column, invert_signs)
Group.new("GruvboxGreenSign", green, sign_column, invert_signs)
Group.new("GruvboxOrangeSign", orange, sign_column, invert_signs)
Group.new("GruvboxPurpleSign", purple, sign_column, invert_signs)
Group.new("GruvboxRedSign", red, sign_column, invert_signs)
Group.new("GruvboxYellowSign", yellow, sign_column, invert_signs)

-- underlines
Group.new("GruvboxAquaUnderline", nil, nil, styles.undercurl, red)
Group.new("GruvboxBlueUnderline", nil, nil, styles.undercurl, blue)
Group.new("GruvboxGreenUnderline", nil, nil, styles.undercurl, green)
Group.new("GruvboxOrangeUnderline", nil, nil, styles.undercurl, orange)
Group.new("GruvboxPurpleUnderline", nil, nil, styles.undercurl, purple)
Group.new("GruvboxRedUnderline", nil, nil, styles.undercurl, red)
Group.new("GruvboxYellowUnderline", nil, nil, styles.undercurl, yellow)

-- base highlight groups
Group.new("Normal", fg0, bg0)
Group.new("CursorLine", nil, bg1)
Group.new("CursorColumn", groups.CursorLine, groups.CursorLine, groups.CursorLine)
Group.new("TabLineFill", bg4, bg1, invert_tabline)
Group.new("TabLineSel", tabline_sel, bg1, invert_tabline)
Group.new("TabLine", groups.TabLineFill, groups.TabLineFill, groups.TabLineFill)
Group.new("MatchParen", nil, bg3, styles.bold)
Group.new("ColorColumn", nil, color_column)
Group.new("Conceal", blue, nil)
Group.new("CursorLineNr", yellow, bg1)
Group.new("NonText", groups.GruvboxBg2, groups.GruvboxBg2, groups.GruvboxBg2)
Group.new("SpecialKey", groups.GruvboxFg4, groups.GruvboxFg4, groups.GruvboxFg4)
Group.new("Visual", nil, bg3, invert_selection)
Group.new("VisualNOS", groups.Visual, groups.Visual, groups.Visual)
Group.new("Search", hls_highlight, bg0, styles.inverse)
Group.new("IncSearch", hls_cursor, bg0, styles.inverse)
Group.new("QuickFixLine", bg0, yellow, styles.bold)
Group.new("Underlined", blue, nil, styles.underline)
Group.new("StatusLine", bg2, fg1, styles.inverse)
Group.new("StatusLineNC", bg1, fg4, styles.inverse)
Group.new("VertSplit", bg3, vert_split)
Group.new("WildMenu", blue, bg2, styles.bold)
Group.new("Directory", groups.GruvboxGreenBold, groups.GruvboxGreenBold,
          groups.GruvboxGreenBold)
Group.new("Title", groups.GruvboxGreenBold, groups.GruvboxGreenBold,
          groups.GruvboxGreenBold)
Group.new("ErrorMsg", bg0, red, styles.bold)
Group.new("MoreMsg", groups.GruvboxYellowBold, groups.GruvboxYellowBold,
          groups.GruvboxYellowBold)
Group.new("ModeMsg", groups.GruvboxYellowBold, groups.GruvboxYellowBold,
          groups.GruvboxYellowBold)
Group.new("Question", groups.GruvboxOrangeBold, groups.GruvboxOrangeBold,
          groups.GruvboxOrangeBold)
Group.new("WarningMsg", groups.GruvboxRedBold, groups.GruvboxRedBold,
          groups.GruvboxRedBold)
Group.new("LineNr", bg4, number_column)
Group.new("SignColumn", nil, sign_column)
Group.new("Folded", colors.gray, bg1, styles.italic)
Group.new("FoldColumn", colors.gray, groups.GruvboxBg1)
Group.new("Cursor", nil, nil, styles.inverse)
Group.new("iCursor", groups.Cursor, groups.Cursor, groups.Cursor)
Group.new("lCursor", groups.Cursor, groups.Cursor, groups.Cursor)
Group.new("vCursor", groups.Cursor, groups.Cursor, groups.Cursor)

-- Syntax highlight
if vim.g.gruvbox_improved_strings then
  Group.new("Special", orange, bg1, italic_strings)
  Group.new("String", fg1, bg1, italic_strings)
else
  Group.new("Special", groups.GruvboxOrange, groups.GruvboxOrange, groups.GruvboxOrange)
  Group.new("String", green, nil, italic_strings)
end

-- TODO(ellisonleao)
Group.new("Comment", colors.gray, nil, italic_comments)
Group.new("Todo", fg0, bg0, styles.bold + styles.italic)
Group.new("Error", red, bg0, styles.bold + styles.inverse)
Group.new("Statement", groups.GruvboxRed, groups.GruvboxRed, groups.GruvboxRed)
Group.new("Conditional", groups.GruvboxRed, groups.GruvboxRed, groups.GruvboxRed)
Group.new("Repeat", groups.GruvboxRed, groups.GruvboxRed, groups.GruvboxRed)
Group.new("Label", groups.GruvboxRed, groups.GruvboxRed, groups.GruvboxRed)
Group.new("Exception", groups.GruvboxRed, groups.GruvboxRed, groups.GruvboxRed)
Group.new("Operator", groups.GruvboxFg1, groups.GruvboxFg1, groups.GruvboxFg1)
Group.new("Keyword", groups.GruvboxRed, groups.GruvboxRed, groups.GruvboxRed)
Group.new("Identifier", groups.GruvboxBlue, groups.GruvboxBlue, groups.GruvboxBlue)
Group.new("Function", groups.GruvboxGreenBold, groups.GruvboxGreenBold,
          groups.GruvboxGreenBold)
Group.new("PreProc", groups.GruvboxAqua, groups.GruvboxAqua, groups.GruvboxAqua)
Group.new("Include", groups.GruvboxAqua, groups.GruvboxAqua, groups.GruvboxAqua)
Group.new("Define", groups.GruvboxAqua, groups.GruvboxAqua, groups.GruvboxAqua)
Group.new("Macro", groups.GruvboxAqua, groups.GruvboxAqua, groups.GruvboxAqua)
Group.new("PreCondit", groups.GruvboxAqua, groups.GruvboxAqua, groups.GruvboxAqua)
Group.new("Constant", groups.GruvboxPurple, groups.GruvboxPurple, groups.GruvboxPurple)
Group.new("Character", groups.GruvboxPurple, groups.GruvboxPurple, groups.GruvboxPurple)
Group.new("Boolean", groups.GruvboxPurple, groups.GruvboxPurple, groups.GruvboxPurple)
Group.new("Number", groups.GruvboxPurple, groups.GruvboxPurple, groups.GruvboxPurple)
Group.new("Float", groups.GruvboxPurple, groups.GruvboxPurple, groups.GruvboxPurple)
Group.new("Type", groups.GruvboxYellow, groups.GruvboxYellow, groups.GruvboxYellow)
Group.new("StorageClass", groups.GruvboxOrange, groups.GruvboxOrange,
          groups.GruvboxOrange)
Group.new("Structure", groups.GruvboxAqua, groups.GruvboxAqua, groups.GruvboxAqua)
Group.new("Typedef", groups.GruvboxYellow, groups.GruvboxYellow, groups.GruvboxYellow)

-- Completion menu
Group.new("Pmenu", fg1, bg2)
Group.new("PmenuSel", bg2, blue, styles.bold)
Group.new("PmenuSbar", nil, bg2)
Group.new("PmenuThumb", nil, bg4)

-- Diffs
Group.new("DiffDelete", red, bg0, styles.inverse)
Group.new("DiffAdd", green, bg0, styles.inverse)
Group.new("DiffChange", aqua, bg0, styles.inverse)
Group.new("DiffText", yellow, bg0, styles.inverse)

-- Spelling
if vim.fn.has("spell") == 1 then
  Group.new("SpellBad", groups.GruvboxRedUnderline, groups.GruvboxRedUnderline,
            groups.GruvboxRedUnderline)
  Group.new("SpellLocal", groups.GruvboxAquaUnderline, groups.GruvboxAquaUnderline,
            groups.GruvboxAquaUnderline)
  Group.new("SpellRare", groups.GruvboxPurpleUnderline, groups.GruvboxPurpleUnderline,
            groups.GruvboxPurpleUnderline)

  if vim.g.gruvbox_improved_warnings then
    Group.new("SpellCap", green, nil, styles.bold + styles.underline)
  else
    Group.new("SpellRare", groups.GruvboxBlueUnderline, groups.GruvboxBlueUnderline,
              groups.GruvboxBlueUnderline)
  end
end

-- Markdown
Group.new("markdownItalic", fg3, nil, styles.italic)
Group.new("markdownLinkText", colors.gray, nil, styles.underline)
Group.new("markdownH1", groups.GruvboxGreenBold, groups.GruvboxGreenBold,
          groups.GruvboxGreenBold)
Group.new("markdownH2", groups.GruvboxGreenBold, groups.GruvboxGreenBold,
          groups.GruvboxGreenBold)
Group.new("markdownH3", groups.GruvboxYellowBold, groups.GruvboxYellowBold,
          groups.GruvboxYellowBold)
Group.new("markdownH4", groups.GruvboxYellowBold, groups.GruvboxYellowBold,
          groups.GruvboxYellowBold)
Group.new("markdownH5", groups.GruvboxYellow, groups.GruvboxYellow,
          groups.GruvboxYellow, groups.GruvboxYellow, groups.GruvboxYellow)
Group.new("markdownH6", groups.GruvboxYellow, groups.GruvboxYellow,
          groups.GruvboxYellow, groups.GruvboxYellow, groups.GruvboxYellow)
Group.new("markdownCode", groups.GruvboxAqua, groups.GruvboxAqua, groups.GruvboxAqua,
          groups.GruvboxAqua, groups.GruvboxAqua)
Group.new("markdownCodeBlock", groups.GruvboxAqua, groups.GruvboxAqua,
          groups.GruvboxAqua)
Group.new("markdownCodeDelimiter", groups.GruvboxAqua, groups.GruvboxAqua,
          groups.GruvboxAqua)
Group.new("markdownBlockquote", groups.GruvboxGray, groups.GruvboxGray,
          groups.GruvboxGray)
Group.new("markdownListMarker", groups.GruvboxGray, groups.GruvboxGray,
          groups.GruvboxGray)
Group.new("markdownOrderedListMarker", groups.GruvboxGray, groups.GruvboxGray,
          groups.GruvboxGray)
Group.new("markdownRule", groups.GruvboxGray, groups.GruvboxGray, groups.GruvboxGray,
          groups.GruvboxGray, groups.GruvboxGray)
Group.new("markdownHeadingRule", groups.GruvboxGray, groups.GruvboxGray,
          groups.GruvboxGray)
Group.new("markdownUrlDelimiter", groups.GruvboxFg3, groups.GruvboxFg3,
          groups.GruvboxFg3)
Group.new("markdownLinkDelimiter", groups.GruvboxFg3, groups.GruvboxFg3,
          groups.GruvboxFg3)
Group.new("markdownLinkTextDelimiter", groups.GruvboxFg3, groups.GruvboxFg3,
          groups.GruvboxFg3)
Group.new("markdownHeadingDelimiter", groups.GruvboxOrange, groups.GruvboxOrange,
          groups.GruvboxOrange)
Group.new("markdownUrl", groups.GruvboxPurple, groups.GruvboxPurple,
          groups.GruvboxPurple)
Group.new("markdownUrlTitleDelimiter", groups.GruvboxGreen, groups.GruvboxGreen,
          groups.GruvboxGreen)
Group.new("markdownIdDeclaration", groups.markdownLinkText, groups.markdownLinkText,
          groups.markdownLinkText)

-- netrw
Group.new("netrwDir", groups.GruvboxAqua, groups.GruvboxAqua, groups.GruvboxAqua)
Group.new("netrwClassify", groups.GruvboxAqua, groups.GruvboxAqua, groups.GruvboxAqua)
Group.new("netrwLink", groups.GruvboxGray, groups.GruvboxGray, groups.GruvboxGray)
Group.new("netrwSymLink", groups.GruvboxFg1, groups.GruvboxFg1, groups.GruvboxFg1)
Group.new("netrwExe", groups.GruvboxYellow, groups.GruvboxYellow, groups.GruvboxYellow)
Group.new("netrwComment", groups.GruvboxGray, groups.GruvboxGray, groups.GruvboxGray)
Group.new("netrwList", groups.GruvboxBlue, groups.GruvboxBlue, groups.GruvboxBlue)
Group.new("netrwHelpCmd", groups.GruvboxAqua, groups.GruvboxAqua, groups.GruvboxAqua)
Group.new("netrwCmdSep", groups.GruvboxFg3, groups.GruvboxFg3, groups.GruvboxFg3)
Group.new("netrwVersion", groups.GruvboxGreen, groups.GruvboxGreen, groups.GruvboxGreen)

-- LSP
Group.new("LspDiagnosticsDefaultError", groups.GruvboxRed, groups.GruvboxRed,
          groups.GruvboxRed)
Group.new("LspDiagnosticsSignError", groups.GruvboxRedSign, groups.GruvboxRedSign,
          groups.GruvboxRedSign)
Group.new("LspDiagnosticsUnderlineError", groups.GruvboxRedUnderline,
          groups.GruvboxRedUnderline, groups.GruvboxRedUnderline)

Group.new("LspDiagnosticsDefaultWarning", groups.GruvboxYellow, groups.GruvboxYellow,
          groups.GruvboxYellow)
Group.new("LspDiagnosticsSignWarning", groups.GruvboxYellowSign,
          groups.GruvboxYellowSign, groups.GruvboxYellowSign)
Group.new("LspDiagnosticsUnderlineWarning", groups.GruvboxYellowUnderline,
          groups.GruvboxYellowUnderline, groups.GruvboxYellowUnderline)

Group.new("LspDiagnosticsDefaultInformation", groups.GruvboxBlue, groups.GruvboxBlue,
          groups.GruvboxBlue)
Group.new("LspDiagnosticsSignInformation", groups.GruvboxBlueSign,
          groups.GruvboxBlueSign, groups.GruvboxBlueSign)
Group.new("LspDiagnosticsUnderlineInformation", groups.GruvboxBlueUnderline,
          groups.GruvboxBlueUnderline, groups.GruvboxBlueUnderline)

Group.new("LspDiagnosticsDefaultHint", groups.GruvboxAqua, groups.GruvboxAqua,
          groups.GruvboxAqua)
Group.new("LspDiagnosticsSignHint", groups.GruvboxAquaSign, groups.GruvboxAquaSign,
          groups.GruvboxAquaSign)
Group.new("LspDiagnosticsUnderlineHint", groups.GruvboxAquaUnderline,
          groups.GruvboxAquaUnderline, groups.GruvboxAquaUnderline)

-- Nvim Treesitter Groups (descriptions and ordering from `:h nvim-treesitter-highlights`)
--Group.new("TSError", groups.Error, bg0, styles.bold) -- For syntax/parser errors
--Group.new("TSPunctDelimiter", bg0, gr) -- For delimiters ie: `.
--Group.new("TSPunctBracket", fg0, nil) -- For brackets and parens
--Group.new("TSPunctSpecial", fg0, nil) -- For special punctutation that does not fall in the catagories before
--Group.new("TSConstant", groups.Constant, bg0) -- For constants
--Group.new("TSConstBuiltin", groups.Constant, bg0) -- For constant that are built in the language: `nil` in Lua
--Group.new("TSConstMacro", g.Constant, bg0) -- For constants that are defined by macros: `NULL` in C
--Group.new("TSString", g.String, c.bg0) -- For strings
--Group.new("TSStringRegex"        , c.fg_escape_char_construct , nil) -- For regexes
--Group.new("TSStringEscape"       , c.fg_escape_char_backslash , nil) -- For escape characters within a string
--Group.new("TSCharacter", g.Character, c.bg0) -- For characters
--Group.new("TSNumber", g.Number, c.bg0) -- For integers
--Group.new("TSBoolean", g.Boolean, c.bg0) -- For booleans
--Group.new("TSFloat", g.Float, c.bg0) -- For floats
--Group.new("TSFunction", g.Function, c.bg0) -- For function (calls and definitions
--Group.new("TSFuncBuiltin", g.Function, c.bg0) -- For builtin functions: `table.insert` in Lua
--Group.new("TSFuncMacro", g.Function, c.bg0) -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
--Group.new("TSParameter"          , c.cyan              , c.none  , s.none) -- For parameters of a function.
--Group.new("TSParameterReference" , g.TSParameter     , nil) -- For references to parameters of a function.
--Group.new("TSMethod", g.Function, c.bg0) -- For method calls and definitions.
--Group.new("TSField"    , c.magenta_alt_other , c.none  , s.none) -- For fields.
--Group.new("TSProperty"    , g.TSField , c.none  , s.none) -- Same as `TSField`.
--Group.new("TSConstructor"        , c.magenta_alt       , c.none)  -- For constructor calls and definitions: `{}` in Lua, and Java constructors
--Group.new("TSConditional", g.Conditional, c.bg0) -- For keywords related to conditionnals
--Group.new("TSRepeat", g.Repeat, c.bg0) -- For keywords related to loops
--Group.new("TSLabel", g.Label, c.bg0) -- For labels: `label:` in C and `:label:` in Lua
--Group.new("TSOperator", g.Operator, c.bg0) -- For any operator: `+`, but also `->` and `*` in C
--Group.new("TSKeyword", g.Keyword, c.bg0) -- For keywords that don't fall in previous categories.
--Group.new("TSKeywordFunction"    , c.magenta_alt       , c.none  , s.none) -- For keywords used to define a fuction.
--Group.new("TSException", g.Exception, c.bg0) -- For exception related keywords.
--Group.new("TSType", g.Type, c.bg0, s.none) -- For types.
--Group.new("TSTypeBuiltin", g.Type, c.bg0, s.none) -- For builtin types (you guessed it, right ?).
--Group.new("TSStructure", g.Structure, c.bg0) -- This is left as an exercise for the reader.
--Group.new("TSInclude", g.Include, c.bg0) -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
--Group.new("TSAnnotation"         , c.blue , c.none) -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
--Group.new("TSText"             , c.fg              , c.bg           , styles.bold) -- For strings considered text in a markup language.
--Group.new("TSStrong"             , c.fg              , c.bg           , styles.bold) -- For text to be represented with strong.
--Group.new("TSEmphasis"            , c.blue_alt          , c.none  , styles.bold) -- For text to be represented with emphasis.
--Group.new("TSUnderline"            , c.blue_alt          , c.none  , styles.bold) -- TSUnderline
--Group.new("TSTitle"              , c.cyan_nuanced    , c.none) -- Text that is part of a title.
--Group.new("TSLiteral"            , c.blue_alt          , c.none  , styles.bols) -- Literal text.
--Group.new("TSURI"           , c.cyan              , c.none  , s.none) -- Any URI like a link or email.
--Group.new("TSVariable"           , c.cyan              , c.none  , s.none) -- Any URI like a link or email.
--Group.new("TSVariableBuiltin" , g.magenta_alt_other     , nil) -- Variable names that are defined by the languages, like `this` or `self`.

-------------------------
-- Plugin Highlighting --
-------------------------
-- Express-Line
Group.new("ElNormal", bg0, fg4, styles.bold)
Group.new("ElInsert", bg0, red, styles.bold)
Group.new("ElReplace", bg0, aqua, styles.bold)
Group.new("ElCommand", bg0, purple, styles.bold)
Group.new("ElTerm", bg0, green, styles.bold)
Group.new("ElVisual", bg0, orange, styles.bold)
Group.new("ElVisualLine",  g.ElVisual, g.ElVisual, g.ElVisual)
Group.new("ElVisualBlock", g.ElVisual, g.ElVisual, g.ElVisual)

-- Galaxyline default providers
Group.new("GalaxyGitBranch", fg0, blue, nil)
Group.new("GalaxyGitBranchSeparator", yellow, bg0, nil)
Group.new("GalaxyDiffAdd", groups.DiffAdd, nil, styles.bold)
Group.new("GalaxyDiffModified", groups.DiffChange, nil, styles.bold)
Group.new("GalaxyDiffRemove", groups.DiffDelete, nil, styles.bold)
Group.new("GalaxyScrollbar", green, bg0, nil)
Group.new("GalaxyLinePercent", fg0, bg0, nil)
Group.new("GalaxyFileTypeName", fg0, bg0, styles.bold)
Group.new("GalaxyFileName", blue, bg0, styles.bold)
Group.new("GalaxyFileIcon", groups.GalaxyFileName, groups.GalaxyFileName,
          groups.GalaxyFileName)
Group.new("GalaxyFileSize", groups.GalaxyFileName, groups.GalaxyFileName,
          groups.GalaxyFileName)
Group.new("GalaxyFileEncode", groups.GalaxyFileName, groups.GalaxyFileName,
          groups.GalaxyFileName)
Group.new("GalaxyFileFormat", groups.GalaxyFileName, groups.GalaxyFileName,
          groups.GalaxyFileName)
Group.new("GalaxyDiagnosticError", groups.LspDiagnosticsDefaultError,
          groups.LspDiagnosticsDefaultError, groups.LspDiagnosticsDefaultError)
Group.new("GalaxyDiagnosticWarn", groups.LspDiagnosticsDefaultWarning,
          groups.LspDiagnosticsDefaultWarning, groups.LspDiagnosticsDefaultWarning)
Group.new("GalaxyDiagnosticHint", groups.LspDiagnosticsDefaultHint,
          groups.LspDiagnosticsDefaultHint, groups.LspDiagnosticsDefaultHint)
Group.new("GalaxyDiagnosticInformation", groups.LspDiagnosticsDefaultInformation,
          groups.LspDiagnosticsDefaultInformation,
          groups.LspDiagnosticsDefaultInformation)

-- start-screen
Group.new("StartifyTitle", orange, nil, styles.bold)
Group.new("StartifyBracket", groups.GruvboxFg3, groups.GruvboxFg3, groups.GruvboxFg3)
Group.new("StartifyFile", groups.GruvboxFg1, groups.GruvboxFg1, groups.GruvboxFg1)
Group.new("StartifyNumber", groups.GruvboxBlue, groups.GruvboxBlue, groups.GruvboxBlue)
Group.new("StartifyPath", groups.GruvboxGray, groups.GruvboxGray, groups.GruvboxGray)
Group.new("StartifySlash", groups.GruvboxGray, groups.GruvboxGray, groups.GruvboxGray)
Group.new("StartifySection", groups.GruvboxYellow, groups.GruvboxYellow,
          groups.GruvboxYellow)
Group.new("StartifySpecial", groups.GruvboxBg2, groups.GruvboxBg2, groups.GruvboxBg2)
Group.new("StartifyHeader", groups.GruvboxOrange, groups.GruvboxOrange,
          groups.GruvboxOrange)
Group.new("StartifyFooter", groups.GruvboxBg2, groups.GruvboxBg2, groups.GruvboxBg2)

-- Signify (mhinz/vim-signify)
Group.new("SignifySignAdd", groups.GruvboxGreenSign, groups.GruvboxGreenSign,
          groups.GruvboxGreenSign)
Group.new("SignifySignChange", groups.GruvboxAquaSign, groups.GruvboxAquaSign,
          groups.GruvboxAquaSign)
Group.new("SignifySignDelete", groups.GruvboxRedSign, groups.GruvboxRedSign,
          groups.GruvboxRedSign)

-- Which Key (liuchengxu/vim-which-key)
Group.new('WhichKey',          green, bg0)
Group.new('WhichKeySeperator', green, bg0)
Group.new('WhichKeyGroup',     red, bg0)
Group.new('WhichKeyDesc',      blue, bg0)
Group.new('WhichKeyFloating',  bg0, nil)

