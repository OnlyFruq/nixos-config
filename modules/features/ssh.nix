{ ... }:
{
  flake.modules.homeManager.ssh =
    { config, ... }:
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        matchBlocks = {
          "github.com" = {
            user = "git";
            identityFile = "~/.ssh/id_ed25519";
          };
        };
      };

      home.file."${config.home.homeDirectory}/.ssh/known_hosts" = {
        text = ''
          github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
        '';
        force = true;
      };
    };
}
