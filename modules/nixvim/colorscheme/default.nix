{ helpers, ... }:
{
  extraConfigLuaPost = # lua
    ''
    '';


  colorschemes.nord = {
    enable = false;
    settings = {
      borders = true;
      contrast = false;
      disable_background = false;
      enable_sidebar_background = true;
    };
  };
}
