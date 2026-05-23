{ ... }:
{
  flake.modules.homeManager.kitty =
    { pkgs, ... }:
    {
      programs.kitty = {
        enable = true;
        font = {
          name = "JetBrainsMono Nerd Font";
          package = pkgs.nerd-fonts.jetbrains-mono;
          size = 10;
        };
        settings = {
          background_opacity = "0.65";
          wheel_scroll_multiplier = "5.0";
        };
      };
    };
}
