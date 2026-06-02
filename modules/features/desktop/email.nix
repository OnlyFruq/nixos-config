{ ... }:
{
  flake.modules.homeManager.email = {
    programs.thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
      };
    };
  };
}
