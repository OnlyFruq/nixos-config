{ ... }:
{
  flake.modules.nixos.user-groups =
    { lib, config, ... }:
    {
      home-manager.sharedModules = [
        (
          { lib, ... }:
          {
            options.userCfg.extraGroups = lib.mkOption {
              type = with lib.types; listOf str;
              default = [ ];
            };
          }
        )
      ];

      users.users = lib.mapAttrs (_name: hm: {
        extraGroups = builtins.filter (g: config.users.groups ? ${g}) hm.userCfg.extraGroups;
      }) config.home-manager.users;
    };
}
