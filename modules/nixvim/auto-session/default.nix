{
  plugins.auto-session = {
    enable = true;

    settings = {
      bypassSessionSaveFileTypes = [
        "dashboard"
        "nvim-tree"
      ];

      auto_restore = true;
      auto_save = true;
      auto_session = {
        enabled = true;
        createEnabled = true;
        useGitBranch = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      action = "<cmd>Telescope session-lens<cr>";
      key = "<leader>fs";
      options = {
        desc = "Find Session";
      };
    }
  ];
}
