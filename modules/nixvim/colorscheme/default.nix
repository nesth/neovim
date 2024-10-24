{ helpers, ... }:
{
  extraConfigLuaPost = # lua
    ''
    '';


  colorschemes.onedark = {
    enable = true;
    settings = {
      borders = true;
      contrast = false;
      disable_background = false;
      enable_sidebar_background = true;
    };
  };
}
