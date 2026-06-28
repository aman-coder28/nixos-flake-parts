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

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    system.stateVersion = "26.11";
  };
}
