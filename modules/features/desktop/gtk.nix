{ ... }:
{
  flake.modules.homeManager.gtk =
    { pkgs, config, ... }:
    {
      gtk = {
        enable = true;
        theme = {
          name = "Everforest-Green-Dark";
          package = pkgs.everforest-gtk-theme;
        };
        cursorTheme = {
          name = "everforest-cursors";
          package = pkgs.everforest-cursors;
          size = 24;
        };
        gtk4.theme = config.gtk.theme;
      };

      home.sessionVariables.XCURSOR_THEME = "everforest-cursors";
    };
}
