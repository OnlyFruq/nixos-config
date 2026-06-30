{ ... }:
{
  flake.modules.homeManager.fastfetch =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.fastfetch ];
      home.shellAliases.ff = "fastfetch";
    };
}
