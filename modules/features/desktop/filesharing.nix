{ ... }:
{
  flake.modules.nixos.filesharing =
    { ... }:
    {
      # Only reachable over tailscale, not on any other interface.
      networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 53317 ];
      networking.firewall.interfaces."tailscale0".allowedUDPPorts = [ 53317 ];
    };

  flake.modules.homeManager.filesharing =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.localsend ];
    };
}
