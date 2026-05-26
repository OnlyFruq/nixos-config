{ inputs, lib, ... }:
{
  flake.modules.nixos.desktop = {
    imports = with inputs.self.modules.nixos; [
      hostDefault
      niri
      printing
      rdp-work
      filesharing
    ];

    config = {
      hostCfg = {
        audio.enable = lib.mkDefault true;
        niri.enable = lib.mkDefault true;
      };
    };
  };
}
