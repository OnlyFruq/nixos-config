{ inputs, ... }:
{
  flake-file.inputs = {
    preservation = {
      url = "github:nix-community/preservation";
    };
  };

  flake.modules.nixos.persistence =
    { ... }:
    {
      imports = [ inputs.preservation.nixosModules.default ];

      systemd.services."systemd-machine-id-commit".enable = false;

      preservation = {
        enable = true;
        preserveAt."/persist" = {
          directories = [
            "/var/lib/systemd/timers"
          ];
          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ];
        };
      };
    };
}
