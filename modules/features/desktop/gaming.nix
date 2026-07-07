{ ... }:
{
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        the-powder-toy
        ddnet
      ];
    };
}
