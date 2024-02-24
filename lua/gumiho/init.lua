local M = {}
local H = {}

---@param fg string foreground color in #hex
---@param bg string background color in #hex
---@param alpha number alpha value between 0.0 and 1.0
H.blend = function(fg, bg, alpha)
    local fg_r, fg_g, fg_b = tonumber(fg:sub(2, 3), 16) / 255, tonumber(fg:sub(4, 5), 16) / 255, tonumber(fg:sub(6, 7), 16) / 255
    local bg_r, bg_g, bg_b = tonumber(bg:sub(2, 3), 16) / 255, tonumber(bg:sub(4, 5), 16) / 255, tonumber(bg:sub(6, 7), 16) / 255

    local r, g, b = fg_r * alpha + bg_r * (1 - alpha), fg_g * alpha + bg_g * (1 - alpha), fg_b * alpha + bg_b * (1 - alpha)

    return ("#%02X%02X%02X"):format(math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))
end

M.palette = {
    white = "#ffffff",
    black = "#000000",
    red = "#de3d35",
    green = "#3e953a",
    yellow = "#d2b67b",
    blue = "#2f5af3",
    magenta = "#a00095",
    cyan = "#3e953a",
    gray0 = "#bbbbbb",
    gray1 = "#dddddd",
    gray2 = "#ededed",
    gray3 = "#f8f8f8",
    gray4 = "#fbfbfb",
}

M.palette.accent = M.palette.magenta

M.styles = {
    -- User Interface

    floats = { fg = M.palette.black, bg = M.palette.gray4 },

    bars = { fg = M.palette.accent, bg = M.palette.accent, blend = 10 },
    -- bars = { fg = M.palette.black, bg = M.palette.white, bold = true },
    bars_inactive = { fg = M.palette.gray0, bg = M.palette.gray0, blend = 10 },

    separators = { fg = M.palette.white },

    -- Syntax

    comments = { fg = M.palette.gray0 },

    constants = { fg = M.palette.yellow },
    strings = { fg = M.palette.green },

    identifiers = { fg = M.palette.black },
    functions = { fg = M.palette.cyan },

    statements = { fg = M.palette.magenta },

    preprocs = { fg = M.palette.magenta },

    types = { fg = M.palette.yellow },

    specials = { fg = M.palette.magenta },
    delimiters = { fg = M.palette.gray0 },
}

M.colorscheme = function()
    if vim.g.colors_name then
        vim.cmd([[set termguicolors]])
        vim.cmd([[highlight clear]])
        vim.cmd([[syntax reset]])
    end

    vim.g.colors_name = "hayan"

    local palette, styles = M.palette, M.styles

    local highlight = function(name, val)
        if val and val.blend ~= nil and val.bg ~= nil then
            val.bg = H.blend(val.bg, palette.white, val.blend / 100)
        end

        vim.api.nvim_set_hl(0, name, val or {})
    end

    --- :: User Interface

    highlight("Normal", { fg = palette.black, bg = palette.white })
    highlight("NormalFloat", styles.floats)
    highlight("FloatBorder", { fg = palette.accent })
    highlight("FloatTitle", { fg = palette.black })
    highlight("FloatFooter", { fg = palette.black })
    highlight("NormalNC", { fg = palette.black, bg = palette.white })

    highlight("Pmenu", styles.floats)
    highlight("PmenuSel", { bg = palette.gray3, bold = true })
    highlight("PmenuKind", { fg = palette.accent })
    highlight("PmenuKindSel", { fg = palette.accent })
    highlight("PmenuExtra", { fg = palette.gray0 })
    highlight("PmenuExtraSel", { fg = palette.gray0 })
    highlight("PmenuSbar", { bg = palette.gray2 })
    highlight("PmenuThumb", { bg = palette.gray0 })

    highlight("WildMenu", { bg = palette.gray3, bold = true })

    highlight("StatusLine", styles.bars)
    highlight("StatusLineNC", styles.bars_inactive)

    highlight("TabLine", styles.bars_inactive)
    highlight("TabLineFill", {})
    highlight("TabLineSel", styles.bars)

    highlight("WinBar", styles.bars)
    highlight("WinBarNC", styles.bars_inactive)

    highlight("ColorColumn", { bg = palette.gray3 })

    highlight("CurSearch", { bg = palette.yellow, fg = palette.white, bold = true })
    highlight("IncSearch", { bg = palette.red, fg = palette.white, bold = true })
    highlight("Substitute", { bg = palette.red, fg = palette.red, bold = true, blend = 20 })
    highlight("Search", { bg = palette.yellow, blend = 20 })

    highlight("Cursor", { bg = palette.black, fg = palette.white })
    highlight("lCursor", { bg = palette.black, fg = palette.white })
    highlight("CursorIM", { bg = palette.black, fg = palette.white })
    highlight("TermCursor", { reverse = true })
    highlight("TermCursorNC", {})

    highlight("CursorColumn", { bg = palette.gray3 })
    highlight("CursorLine", { bg = palette.gray3 })

    highlight("Conceal", { fg = palette.accent })
    highlight("Directory", { fg = palette.blue })
    highlight("ErrorMsg", { fg = palette.red, bold = true })
    highlight("ModeMsg", { fg = palette.green, bold = true })
    -- highlight("MsgArea", {})
    -- highlight("MsgSeparator", {})
    highlight("MoreMsg", { fg = palette.blue })
    highlight("Question", { fg = palette.blue })
    highlight("Title", { fg = palette.normal, bold = true })
    highlight("WarningMsg", { fg = palette.yellow })

    highlight("EndOfBuffer", { link = "NonText" })
    highlight("NonText", { fg = palette.gray1 })
    highlight("SpecialKey", { link = "Whitespace" })
    highlight("Whitespace", { fg = palette.gray1 })

    highlight("WinSeparator", styles.separators)

    highlight("Folded", { fg = palette.gray1 })

    highlight("FoldColumn", { fg = palette.gray1 })
    highlight("SignColumn", { fg = palette.gray1 })
    highlight("LineNr", { fg = palette.gray1 })
    -- highlight("LineNrAbove", {})
    -- highlight("LineNrBelow", {})
    highlight("CursorLineNr", { fg = palette.accent })
    highlight("CursorLineFold", { fg = palette.gray1 })
    highlight("CursorLineSign", { fg = palette.gray1 })

    highlight("MatchParen", { bg = palette.gray2, bold = true })

    highlight("Visual", { bg = palette.gray2, bold = true })
    highlight("VisualNOS", { bg = palette.gray2, bold = true })

    highlight("QuickFixLine", { bg = palette.gray2, bold = true })

    highlight("DiffAdd", { bg = palette.green, blend = 20 })
    highlight("DiffChange", { bg = palette.yellow, blend = 20 })
    highlight("DiffDelete", { bg = palette.red, blend = 20 })
    highlight("DiffText", { bg = palette.yellow, blend = 10 })

    highlight("SpellBad", { sp = palette.red, undercurl = true })
    highlight("SpellCap", { sp = palette.green, undercurl = true })
    highlight("SpellLocal", { sp = palette.yellow, undercurl = true })
    highlight("SpellRare", { sp = palette.blue, undercurl = true })

    --- Syntax

    highlight("Comment", styles.comments)
    highlight("Constant", styles.constants)
    highlight("String", styles.strings)
    highlight("Character", { link = "Constant" })
    highlight("Number", { link = "Constant" })
    highlight("Boolean", { link = "Constant" })
    highlight("Float", { link = "Constant" })

    highlight("Identifier", styles.identifiers)
    highlight("Function", styles.functions)

    highlight("Statement", styles.statements)
    highlight("Conditional", { link = "Statement" })
    highlight("Repeat", { link = "Statement" })
    highlight("Label", { link = "Statement" })
    highlight("Operator", { link = "Statement" })
    highlight("Keyword", { link = "Statement" })
    highlight("Exception", { link = "Statement" })

    highlight("PreProc", styles.preprocs)
    highlight("Include", { link = "PreProc" })
    highlight("Define", { link = "PreProc" })
    highlight("Macro", { link = "PreProc" })
    highlight("PreCondit", { link = "PreProc" })

    highlight("Type", styles.types)
    highlight("StorageClass", { link = "Type" })
    highlight("Structure", { link = "Type" })
    highlight("Typedef", { link = "Type" })

    highlight("Special", styles.specials)
    highlight("SpecialChar", { link = "Special" })
    highlight("Tag", { link = "Special" })
    highlight("Delimiter", styles.delimiters)
    highlight("SpecialComment", { link = "Special" })
    highlight("Debug", { link = "Special" })

    highlight("Underlined", { underline = true })
    -- highlight("Ignore")
    highlight("Error", { fg = palette.red, bold = true })
    highlight("Todo", { fg = palette.text, bold = true })
    highlight("Added", { fg = palette.green })
    highlight("Changed", { fg = palette.yellow })
    highlight("Removed", { fg = palette.red })

    --- Diagnostics

    highlight("DiagnosticError", { fg = palette.red })
    highlight("DiagnosticWarn", { fg = palette.yellow })
    highlight("DiagnosticInfo", { fg = palette.cyan })
    highlight("DiagnosticHint", { fg = palette.blue })
    highlight("DiagnosticOk", { fg = palette.green })

    highlight("DiagnosticFloatingError", { fg = palette.red })
    highlight("DiagnosticFloatingWarn", { fg = palette.yellow })
    highlight("DiagnosticFloatingInfo", { fg = palette.cyan })
    highlight("DiagnosticFloatingHint", { fg = palette.blue })
    highlight("DiagnosticFloatingOk", { fg = palette.green })

    highlight("DiagnosticSignError", { link = "DiagnosticFloatingError" })
    highlight("DiagnosticSignHint", { link = "DiagnosticFloatingHint" })
    highlight("DiagnosticSignInfo", { link = "DiagnosticFloatingInfo" })
    highlight("DiagnosticSignOk", { link = "DiagnosticFloatingOk" })
    highlight("DiagnosticSignWarn", { link = "DiagnosticFloatingWarn" })

    highlight("DiagnosticUnderlineError", { underline = true, sp = palette.red })
    highlight("DiagnosticUnderlineHint", { underline = true, sp = palette.yellow })
    highlight("DiagnosticUnderlineInfo", { underline = true, sp = palette.cyan })
    highlight("DiagnosticUnderlineOk", { underline = true, sp = palette.blue })
    highlight("DiagnosticUnderlineWarn", { underline = true, sp = palette.green })

    --- Treesitter

    highlight("@variable", { link = "Identifier" })

    --- LSP

    highlight("LspInlayHint", { fg = palette.gray0, bg = palette.gray0, blend = 10 })

    --- Mini

    highlight("MiniHipatternsFixme", { fg = palette.white, bg = palette.red, bold = true })
    highlight("MiniHipatternsHack", { fg = palette.white, bg = palette.yellow, bold = true })
    highlight("MiniHipatternsTodo", { fg = palette.white, bg = palette.cyan, bold = true })
    highlight("MiniHipatternsNote", { fg = palette.white, bg = palette.blue, bold = true })
end

return M
