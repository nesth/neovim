{ helpers, pkgs, ... }:
let
  thunk =
    body:
    helpers.mkRaw ''
      function()
        ${body}
      end
    '';
in
{
  extraPackages = with pkgs; [
    nixfmt-rfc-style
  ];

  extraPlugins = with pkgs.vimPlugins; [
    actions-preview-nvim
  ];

  extraConfigLua = ''
    		do
    			require("actions-preview").setup({
    				diff = {
    					ignore_whitespace = true,
    				},
    				highlight_command = {
    					require("actions-preview.highlight").diff_highlight()
    				},
    				backend = { "telescope" },
    			})
    		end
    	'';

  extraConfigLuaPre = ''
    do
      local diagnostic_signs = { Error = "", Warn = "", Hint = "", Info = "" }

      for type, icon in pairs(diagnostic_signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        update_in_insert = true,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      })
    end
  '';

  autoCmd = [
    {
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [
        "*.txt"
        "*.md"
        "*.tex"
        "LICENSE"
      ];
      command = "setlocal spell";
    }
  ];

  plugins.lsp = {
    enable = true;
    inlayHints = true;

    keymaps = {
      silent = true;

      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };

      lspBuf = {
        K = "hover";
        gh = "hover";
        gr = "references";
        gd = "definition";
        gi = "implementation";
        gD = "type_definition";
      };

      extra = [
        {
          action = thunk "vim.cmd [[<cmd>LspStop<CR>]]";
          key = "<leader>lx";
          options = {
            desc = "LSP: Stop";
            silent = true;
          };
        }
        {
          action = thunk "vim.cmd [[<cmd>LspStart<CR>]]";
          key = "<leader>ls";
          options = {
            desc = "LSP: Start";
            silent = true;
          };
        }
        {
          action = thunk "vim.cmd [[<cmd>LspRestart<CR>]]";
          key = "<leader>lr";
          options = {
            desc = "LSP: Restart";
            silent = true;
          };
        }
        {
          action =
            helpers.mkRaw
              # lua
              ''
                require('telescope.builtin').lsp_definitions
              '';
          key = "<leader>gd";
          options = {
            desc = "LSP: Definitions";
            silent = true;
          };
        }
        {
          action =
            helpers.mkRaw
              # lua
              ''
                require('actions-preview').code_actions
              '';
          key = "<leader>ca";
          options = {
            desc = "LSP: Code Actions";
            silent = true;
          };
        }
      ];
    };

    servers = {
      clangd.enable = true;
      cmake.enable = true;
      dockerls.enable = true;
      docker_compose_language_service.enable = true;
      gopls.enable = true;
      graphql.enable = true;
      helm_ls.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      nixd = {
        enable = true;
        # HACK : https://github.com/nix-community/nixvim/issues/2390
        extraOptions = {
          offset_encoding = "utf-8";
        };
        settings = {
          nixpkgs = {
            expr = "import <nixpkgs> {}";
          };
          formatting = {
            command = [ "nixpkgs-fmt" ];
          };
          options = {
            nixos = {
              expr = ''
                let configs = (builtins.getFlake ("git+file://" + builtins.toString ./.)).nixosConfigurations; in (builtins.head (builtins.attrValues configs)).options
              '';
            };
            home_manager = {
              expr = ''
                let configs = (builtins.getFlake ("git+file://" + builtins.toString ./.)).homeConfigurations; in (builtins.head (builtins.attrValues configs)).options
              '';
            };
            darwin = {
              expr = ''
                let configs = (builtins.getFlake ("git+file://" + builtins.toString ./.)).darwinConfigurations; in (builtins.head (builtins.attrValues configs)).options
              '';
            };
          };
        };
      };
      pyright.enable = true;
      sqls.enable = true;
      terraformls.enable = true;
      yamlls = {
        enable = true;
        extraOptions = {
          settings = {
            yaml = {
              schemaStore.enable = true;
              format = {
                enable = true;
              };
              completion = true;
            };
          };
        };
      };
    };
  };
}
