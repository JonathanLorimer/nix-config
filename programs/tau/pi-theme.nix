{
  pkgs,
  colorscheme,
}: let
  c = colorscheme;
in
  pkgs.writeText "zenwritten-desat.json" (builtins.toJSON {
    "$schema" = "https://raw.githubusercontent.com/earendil-works/pi/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json";
    name = "zenwritten-desat";

    # Named aliases used in the colors block below
    vars = {
      bg = c.base00;
      bgAlt = c.base01;
      selection = c.base02;
      comment = c.base03;
      grayMid = c.base04;
      text = c.base05;
      textLight = c.base06;
      red = c.base08;
      orange = c.base09;
      yellow = c.base0A;
      green = c.base0B;
      cyan = c.base0C;
      blue = c.base0D;
      purple = c.base0E;
    };

    colors = {
      # Core UI
      accent = c.base0D;
      border = c.base0D;
      borderAccent = c.base0C;
      borderMuted = c.base02;
      success = c.base0B;
      error = c.base08;
      warning = c.base0A;
      muted = c.base03;
      dim = "#505050";
      text = c.base05;
      thinkingText = c.base03;

      # Message backgrounds — subtle tints of the base bg toward each role colour
      selectedBg = "#303030";
      userMessageBg = c.base01;
      userMessageText = c.base05;
      customMessageBg = "#1e1b21";
      customMessageText = c.base05;
      customMessageLabel = c.base0E;
      toolPendingBg = "#1d1e23";
      toolSuccessBg = "#1c2019";
      toolErrorBg = "#221b1c";
      toolTitle = c.base05;
      toolOutput = c.base03;

      # Markdown
      mdHeading = c.base0A;
      mdLink = c.base0D;
      mdLinkUrl = c.base03;
      mdCode = c.base0C;
      mdCodeBlock = c.base0B;
      mdCodeBlockBorder = c.base03;
      mdQuote = c.base03;
      mdQuoteBorder = c.base03;
      mdHr = c.base02;
      mdListBullet = c.base0D;

      # Diff
      toolDiffAdded = c.base0B;
      toolDiffRemoved = c.base08;
      toolDiffContext = c.base03;

      # Syntax
      syntaxComment = c.base03;
      syntaxKeyword = c.base0E;
      syntaxFunction = c.base0A;
      syntaxVariable = c.base06;
      syntaxString = c.base0B;
      syntaxNumber = c.base09;
      syntaxType = c.base0C;
      syntaxOperator = c.base05;
      syntaxPunctuation = c.base04;

      # Thinking level borders (graduated toward purple)
      thinkingOff = c.base02;
      thinkingMinimal = c.base03;
      thinkingLow = "#6b8593";
      thinkingMedium = c.base0D;
      thinkingHigh = c.base0E;
      thinkingXhigh = "#c9b8c4";

      bashMode = c.base0B;
    };

    export = {
      pageBg = c.base00;
      cardBg = c.base01;
      infoBg = "#222019";
    };
  })
