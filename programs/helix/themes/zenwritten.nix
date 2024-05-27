{ colorscheme }:
let
    bg = colorscheme.base00;
    bgDim = colorscheme.base01;
    bgBright = colorscheme.base02;
    fgBright = colorscheme.base07;
    fg = colorscheme.base05;
    fgDim = colorscheme.base06;
    fgDark = colorscheme.base04;
    green = colorscheme.base0B;
    magenta = colorscheme.base0E;
    orange = colorscheme.base09;
    red = colorscheme.base08;
    yellow = colorscheme.base0A;
    blue = colorscheme.base0D;
in
  {
    "type" = fgBright;
    "constant" = fg;
    "constant.numeric" = magenta;
    "string" = { fg = green; modifiers = ["italic"]; };
    "comment" = fgDark;
    "variable" = fgDim;
    "variable.parameter" = fg;
    "label" = fg;
    "punctuation" = fgDim;
    "keyword" = { fg = fgBright; modifiers = [ "bold" ]; };
    "operator" = fgBright;
    "function" = fgBright;
    "tag" = { fg = fgBright; modifiers = ["bold"]; };
    "namespace" = fg;
    "attribute" = fg;
    "constructor" = { fg = fg; modifiers = [ "bold"]; };
    "module" = { fg = fgBright; modifiers = ["bold" "italic"]; };
    "special" = magenta;

    "markup.heading.marker" = fgDim;
    "markup.heading.1" = { fg = fgBright; modifiers = ["bold"];};
    "markup.heading.2" = { fg = fgBright; modifiers = ["bold"]; };
    "markup.heading.3" = { fg = fgBright; modifiers = ["bold"]; };
    "markup.heading.4" = { fg = fg; modifiers = ["bold"]; };
    "markup.heading.5" = { fg = fg; modifiers = ["bold"]; };
    "markup.heading.6" = { fg = fg; modifiers = ["bold"]; };
    "markup.list" = fg;
    "markup.bold" = { modifiers = ["bold"]; };
    "markup.italic" = { modifiers = ["italic"]; };
    "markup.link.url" = { fg = "green"; modifiers = ["underlined"]; };
    "markup.link.text" = fg;
    "markup.quote" = fgDim;
    "markup.raw" = fg;

    "diff.plus" = green;
    "diff.delta" = blue;
    "diff.minus" = red;

    "ui.background" = { bg = bg; };
    "ui.background.separator" = bgDim;
    "ui.cursor" = { fg = bg; bg = fg; };
    "ui.cursor.match" = { fg = yellow; modifiers = ["bold"]; };
    "ui.cursorline.primary" = { bg = bgDim; };
    "ui.cursorline.secondary" = { bg = bgDim; };
    "ui.selection" = { bg = bgDim; };
    "ui.linenr" = bgBright;
    "ui.linenr.selected" = fg;
    "ui.statusline" = { fg = fg; bg = bg; };
    "ui.statusline.inactive" = { fg = fgDim; bg = bg; };
    "ui.statusline.normal" = { fg = bg; bg = fg; modifiers = ["bold"]; };
    "ui.statusline.insert" = { fg = bg; bg = fg; modifiers = ["bold"]; };
    "ui.statusline.select" = { fg = bg; bg = fg; modifiers = ["bold"]; };
    "ui.popup" = { fg = fg; bg = bgDim; };
    "ui.window" = { fg = fg; bg = bg; };
    "ui.help" = { fg = fg; bg = bg; };
    "ui.text" = fg;
    "ui.text.focus" = { bg = bgDim; fg = fgBright; };
    "ui.menu" = { fg = fg; bg = bg; };
    "ui.menu.selected" = { fg = bgDim; bg = fgBright; };
    "ui.virtual.whitespace" = { fg = bgDim; };
    "ui.virtual.indent-guide" = { fg = bgDim; };
    "ui.virtual.ruler" = { bg = bgDim; };

    "hint" = blue;
    "info" = green;
    "warning" = yellow;
    "error" = red;
    "diagnostic" = { underline = { style = "line"; }; };
    "diagnostic.hint" = { underline = { color = blue; style = "curl"; }; };
    "diagnostic.info" = { underline = { color = green; style = "curl"; }; };
    "diagnostic.warning" = { underline = { color = orange; style = "curl"; }; };
    "diagnostic.error" = { underline = { color = red; style = "curl"; }; };
  }
