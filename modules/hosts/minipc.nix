{ inputs, ... }:
{
  flake.modules.nixos.minipc =
    { ... }:
    {
      imports = with inputs.self.modules.nixos; [
        # base + mechanisms (every host)
        hostDefault
        disko
        persistence
        user-groups
        # user + machine capability
        frugzzz1
        desktop
      ];

      networking.hostName = "minipc";

      diskoCfg = {
        device = "/dev/nvme0n1";
        swapSize = "10G";
        encrypt = false; # kein LUKS-Prompt beim Boot, wie in der VM
      };

      # Typische Module für ein physisches Gerät mit NVMe/SATA + USB-Bootmedium.
      # Nach dem ersten echten Boot ggf. anhand von `nixos-generate-config` prüfen.
      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];

      # HP Pro Mini 400 G9: Intel Core (12./13./14. Gen), Intel UHD Graphics 770,
      # Intel AX211 WiFi 6E + Bluetooth 5.2 (bei WLAN-Ausstattung).
      hardware.cpu.intel.updateMicrocode = true;
      hardware.graphics.enable = true;
      hardware.enableRedistributableFirmware = true; # Firmware für den WiFi-Chip
      hardware.bluetooth.enable = true;

      hostCfg.audio.enable = true;
    };

  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "minipc";
}
