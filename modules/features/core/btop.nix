{ ... }:
{
  flake.modules.homeManager.core = {
    programs.btop = {
      enable = true;
      settings = {
        update_ms = 1000;
        theme_background = false;
      };
    };
  };
}
