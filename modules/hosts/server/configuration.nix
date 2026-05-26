{ inputs, ... }:
{
  flake.modules.nixos.server =
    { ... }:
    {
      imports = with inputs.self.modules.nixos; [
        server-system
        disko
        persistence
        sean
      ];

      hostCfg.user.sean.dev = true;

      diskoConfigDevice = "/dev/disk/by-id/ata-TOSHIBA_MQ01ABD050_93HRC25TT";

      networking.hostName = "server";

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "usbhid"
      ];
    };
}
