{ inputs, ... }:
{
  # A user is a self-contained pair of aspects. To add a user, copy this file,
  # rename `frugzzz1` throughout, adjust the identity block, and add the new user's
  # nixos aspect to a host's imports. The user brings their personal env
  # (core + dev); the *host* brings the machine capability (desktop), so this
  # file is host-agnostic — the same user works on a desktop or a headless host.

  # NixOS aspect: the system account + which HM buckets this user runs.
  flake.modules.nixos.frugzzz1 =
    { pkgs, config, ... }:
    {
      imports = [ inputs.self.modules.nixos.sops ]; # decrypts the login password

      config = {
        sops.secrets.frugzzz1_hashed_password.neededForUsers = true;

        users.users.frugzzz1 = {
          isNormalUser = true;
          description = "frugzzz1";
          linger = true; # keep user services (e.g. tailscale userspace) alive without a login session
          hashedPasswordFile = config.sops.secrets.frugzzz1_hashed_password.path;
          shell = pkgs.zsh;
          extraGroups = [ "wheel" ]; # only genuine identity groups here; feature groups come via userCfg.extraGroups
        };

        # The user's personal home-manager stack. Desktop is NOT here — a desktop
        # host adds it to every user via sharedModules (see desktop/profile.nix).
        home-manager.users.frugzzz1.imports = with inputs.self.modules.homeManager; [
          frugzzz1 # identity below
          core
          dev
        ];
      };
    };

  # Home-Manager aspect: identity only (who this user is). Everything behavioural
  # lives in the feature buckets; only user-specific facts belong here.
  flake.modules.homeManager.frugzzz1 =
    { config, ... }:
    {
      home.stateVersion = "25.11";
      home.username = "frugzzz1";
      home.homeDirectory = "/home/${config.home.username}";

      programs.git.settings.user = {
        name = "OnlyFruq";
        email = "Konto4ruben@gmail.com";
      };
    };
}
