{ pkgs }:
{
  #lean4 lang
  lean = {
    enable = true;
    leanPackage = pkgs.elan;
    abbreviations = {
      enable = true;
      extra = {
        osemic = "⦂"; 

      };
    };

    extraOptions = {
      lsp = {
        on_attach.__raw = ''function()
            vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)
            vim.keymap.set('i', '<C-a>', vim.lsp.buf.code_action)
          end'';
      };
    };

    lsp = {
      enable = true;
    };
    mappings = true;
    
  };

}
