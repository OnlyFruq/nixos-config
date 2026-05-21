{ inputs, ... }: {
  flake.modules.homeManager.opencode =
    { pkgs, ... }: {
      home.shellAliases = {
        c = "opencode";
      };

      programs.opencode = {
        enable = true;
        settings = {
          autoupdate = false;
          lsp = true;
          mcp = {
            nixos = {
              command = [ "${pkgs.mcp-nixos}/bin/mcp-nixos" ];
              enabled = true;
              type = "local";
            };
            python = {
              command = [ "${pkgs.uv}/bin/uvx" "mcp-server-analyzer" ];
              enabled = true;
              type = "local";
              environment = {
                UV_PYTHON = "${pkgs.python3}/bin/python3";
              };
            };
          };
        };
        tui = {
          theme = "system";
        };
      };

      home.packages = with pkgs; [
        nixd
        pyright
        ruff
        uv
      ];
    };
}
