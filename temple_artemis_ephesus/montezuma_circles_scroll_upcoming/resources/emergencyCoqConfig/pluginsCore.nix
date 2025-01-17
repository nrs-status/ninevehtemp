{ pkgs }:
{
  #find-next-character motion
  hop = {
    enable = true;
  };

  telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
  };

  #colored brackets, parentheses, etc.
  rainbow-delimiters.enable = true;

  markdown-preview = {
    enable = true;
    settings = {
      auto_close = true;
      auto_start = true;
      browser = "firefox";
      echo_preview_url = true;
        page_title = "「\${name}」";
  port = "8080";
  preview_options = {
    disable_filename = true;
    disable_sync_scroll = true;
    sync_scroll_type = "middle";
  };
      theme = "dark";
    };
  };


  #automatic nix indentation, filetype detection for .nix files, syntax highlighting for nix
  nix.enable = true;

  #automatically set expandtab (enables spaces instead of tabs) and shiftwidth (amount of whitespace to add or remove when an indentation command is called) automatically
  sleuth.enable = true;

  #commands to add/remove/replace brackets, parenthesis, etc. in combination with motion commands
  surround.enable = false;

  auto-save.enable = true;

  #automatically close brackets, parentheses, etc.
  nvim-autopairs = {
    enable = true;
    settings = {
      map_cr = true; #behaviour of <cr> when cursor is in the following position: {|}
    };
  };
  #pre-existing snippets collection
  friendly-snippets.enable = true;

  #snippets engine
  luasnip = {
    enable = true;
    fromLua = [
      {paths = ../snippets;}
    ];
    fromSnipmate = [
      {}
      {paths = ../snippets;}
    ];
  };

  # git integrations
  gitsigns.enable = true;

  #add indentation guides
  indent-blankline = {
    enable = true;
    settings = {
      exclude = {
        buftypes = ["terminal" "nofile"];
        filetypes = ["help"];
      };
    };
  };

  #status line
  lualine.enable = true;

  #magit-like git interface
  neogit.enable = true;

  #debug adapter protocol client
  dap = {
    enable = true;
    extensions = {
      dap-python.enable = true;
    };
  };

  treesitter = {
    enable = true;
    indent = true;
  };

  #add context at the top of the window, wherever you are
  treesitter-context = {
    enable = false;
    settings = {
      max_lines = 5;
    };
  };

  #folding
  nvim-ufo = {
    enable = true;
    openFoldHlTimeout = 0;
    providerSelector = ''
      function()
        return { "lsp", "indent" }
      end
    '';
  };

  #lsp improvements and prettification
  lspsaga.enable = true;

  conform-nvim = {
    enable = true;
    formattersByFt = {
      clojure = ["cljstyle"];
      haskell = ["ormolu"];
      javascript = ["prettierd"];
      javascriptreact = ["prettierd"];
      typescript = ["prettierd"];
      typescriptreact = ["prettierd"];
      python = ["black"];
      lua = ["stylua"];
      markdown = ["prettierd"];
      nix = ["alejandra"];
      html = ["rustywind" "stylelint" "htmlbeautifier"];
      css = ["stylelint"];
      bash = ["beautysh"];
      cabal = ["cabal_fmt"];
      json = ["fixjson"];
      yaml = ["yamlfmt"];
    };
  };

  #adds pictograms to lsp
  lspkind.enable = true;

  lsp = {
    enable = true; #precisely which are enabled is config'd in each file
    servers = {


      nixd.enable = true;
      lua-ls = {
        enable = true;
        settings.telemetry.enable = false;
      };
      bashls.enable = true;
      coq_lsp.enable = true;
    };
  };

  coq-nvim = {
    enable = true;
  };

  cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      mapping = {
        __raw = ''
          cmp.mapping.preset.insert({
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-c>'] = cmp.mapping.abort(),

          ['<C-b>'] = cmp.mapping.scroll_docs(-4),

           ['<C-w>'] = cmp.mapping.scroll_docs(4),


           ['<C-Space>'] = cmp.mapping.complete(), --invokes completion


           ['<C-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          })
        '';
      };
      sources = [
        #{ --will cause errors if enabled, use the onehere below after the cmp block instead
        #  name = "cmdline";
        #}
         {
           name = "kitty";
         }
        # {
        #   name = "sql";
        # }
      ];
    };
  };

  cmp-cmdline.enable = true;
  cmp-nvim-lsp.enable = true;
  cmp-nvim-lua.enable = true;
  cmp-rg.enable = true;
  cmp-treesitter.enable = true;
  cmp-zsh.enable = true;
  cmp-path.enable = true;
  cmp_luasnip.enable = true;
}
