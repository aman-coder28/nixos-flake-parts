{ ... }: {
  flake.nixosModules.Settings = { ... }: {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    nix.optimise = {
      automatic = true;
      dates = "03:45";
    };

    systemd.services.NetworkManager-wait-online.enable = false;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      NH_OS_FLAKE = "/home/zeamanuel/Code/config/nixos-flake-parts/";
    };

    environment.sessionVariables.PATH = [ "$HOME/.local/bin" ];

    system.stateVersion = "26.11";
  };
}
