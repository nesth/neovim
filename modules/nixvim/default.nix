{ pkgs, ... }:
{
  vimAlias = true;
  viAlias = true;
  withNodeJs = true;
  withRuby = true;

  luaLoader.enable = true;

  extraPlugins = with pkgs.vimPlugins; [
    vim-bufkill
		vim-terraform
  ];

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  autocmd = [
    {
      event = "FileType";
			pattern = "yaml";
			command = "expandtab";
    }
  ];

  opts = {
    smartindent = true;
    breakindent = true;
    cursorline = true;
		cursorcolumn = true;

    tabstop = 2;
    shiftwidth = 2;

    wrap = true;
    linebreak = true;

    number = true;
    relativenumber = false;

    signcolumn = "yes:1";

    mouse = "a";

    foldcolumn = "0";
    foldlevel = 99;
    foldlevelstart = 99;
    foldenable = true;

    updatetime = 50;

    swapfile = false;
    backup = true;
    undofile = true;

    termguicolors = true;

    ignorecase = true;
    smartcase = true;

    splitbelow = true;
    splitright = true;

    scrolloff = 4;

    laststatus = 3;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ch";
      action = "<cmd>noh<cr>";
      options = {
        silent = true;
        desc = "Clear highlight";
      };
    }
    {
      mode = "n";
      key = "<leader>cs";
      action = ''<cmd>let @/=""<cr>'';
      options = {
        silent = true;
        desc = "Clear search";
      };
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>:BD<cr>";
      options = {
        silent = true;
        desc = "Delete buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>:bnext<cr>";
      options = {
        silent = true;
        desc = "Next buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>:bprevious<cr>";
      options = {
        silent = true;
        desc = "Previous buffer";
      };
    }
    {
      mode = "t";
      key = "<C-o>";
      action = ''<C-\><C-n>'';
      options = {
        silent = true;
        desc = "Exit terminal mode";
      };
    }
  ];

	# extraConfigLua = # lua
  #   ''
	# 		vim.opt.backup = true  -- Enable backup file creation
	# 		vim.opt.writebackup = true  -- Keep a backup file while writing

	# 		local ncbackup = {}
	# 		ncbackup.directory = vim.g.ncbackup_directory or (vim.fn.stdpath('data') .. "/ncbackup")
	# 		ncbackup.purge = vim.g.ncbackup_purge or 10

	# 		local function make_backup_dir(path)
	# 		  if vim.fn.isdirectory(path) == 0 then
	# 		    vim.fn.mkdir(path, "p", "0770")
	# 		  end
	# 		end

	# 		local function get_version(filename)
	# 		  return tonumber(filename:match(";(.*)"))
	# 		end

	# 		local function version_compare(left, right)
	# 		  local left_ver = get_version(left)
	# 		  local right_ver = get_version(right)
	# 		  if left_ver == right_ver then
	# 		    return 0
	# 		  elseif left_ver > right_ver then
	# 		    return 1
	# 		  else
	# 		    return -1
	# 		  end
	# 		end

	# 		local function set_backup(doc_path, doc_name)
	# 		  local backup_path = vim.fn.expand(ncbackup.directory) .. '/' .. doc_path:gsub("[:\\]", "/")
	# 		  make_backup_dir(backup_path)
	# 		  vim.opt.backupdir:prepend(vim.fn.fnameescape(backup_path))

	# 		  local existing_backups = {}
	# 		  local glob_results = vim.fn.globpath(backup_path, doc_name .. ";*")
	# 		  if glob_results ~= "" then
	# 		    existing_backups = vim.split(glob_results, "\n")
	# 		    table.sort(existing_backups, version_compare)
	# 		  end

	# 		  if #existing_backups == 0 then
	# 		    vim.opt.backupext = ";1"
	# 		  else
	# 		    local latest_version = get_version(existing_backups[#existing_backups])
	# 		    vim.opt.backupext = ";" .. tostring(latest_version + 1)

	# 		    if ncbackup.purge > 0 and #existing_backups > ncbackup.purge then
	# 		      for i = 1, #existing_backups - ncbackup.purge do
	# 		        vim.fn.delete(existing_backups[i])
	# 		      end
	# 		    end
	# 		  end
	# 		end

	# 		make_backup_dir(vim.fn.expand(ncbackup.directory))
	# 		vim.api.nvim_create_autocmd("BufWritePre", {
	# 		  pattern = "*",
	# 		  callback = function(args)
	# 		    set_backup(vim.fn.expand("<afile>:p:h"), vim.fn.expand("<afile>:p:t"))
	# 		  end
	# 		})
  #   '';
}
