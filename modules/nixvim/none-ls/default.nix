{
  plugins.none-ls = {
    enable = true;

    sources = {
      diagnostics = {
        deadnix.enable = true;
      };
      formatting = {
        hclfmt.enable = true;
      };
    };
  };
}
