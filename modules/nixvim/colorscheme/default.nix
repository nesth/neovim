{ helpers, ... }:
{
  extraConfigLuaPost = # lua
    ''
    '';


  colorschemes.onedark = {
    enable = true;
    settings = {
			style = "warmer";
      borders = true;
      contrast = false;
      disable_background = false;
      enable_sidebar_background = true;
    };
  };
}
