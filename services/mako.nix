{
  colorscheme,
  default-font,
}: {
  enable = true;
  settings = {
    actions = true;
    anchor = "top-right";
    background-color = colorscheme.base00;
    text-color = colorscheme.base04;
    border-color = colorscheme.base03;
    border-radius = 5;
    border-size = 2;
    font = "${default-font} 18";
    default-timeout = 5000;
    layer = "top";
  };
}
