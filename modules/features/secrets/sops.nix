{ inputs, ... }:
let
  ageKeyRelPath = ".keys/age.txt";
in
{
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.sops =
    { config, ... }:
    {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      home.sessionVariables.SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/${ageKeyRelPath}";

      persist.files = [
        {
          file = ageKeyRelPath;
          configureParent = true;
        }
      ];

      sops = {
        defaultSopsFile = ./secrets.yaml;
        age.keyFile = "${config.home.homeDirectory}/${ageKeyRelPath}";
      };

      sops.secrets."sean_ssh_id_ed25519" = {
        path = "${config.home.homeDirectory}/.keys/generated_keys/id_ed25519";
        mode = "0600";
      };

    };

  flake.modules.nixos.sops =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      hmUsers = builtins.attrNames config.home-manager.users;
      primaryUser = lib.head hmUsers;
    in
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      sops = {
        defaultSopsFile = ./secrets.yaml;
        age.keyFile = "/persist/home/${primaryUser}/${ageKeyRelPath}";
      };

      environment.systemPackages = [ pkgs.sops ];
    };
}
