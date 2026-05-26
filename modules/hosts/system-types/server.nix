{ inputs, lib, ... }:
{
  flake.modules.nixos.server-system = {
    imports = with inputs.self.modules.nixos; [
      hostDefault
      ssh
    ];

    config = {
      hostCfg = {
        ssh-server.enable = lib.mkDefault true;
      };
    };
  };
}
