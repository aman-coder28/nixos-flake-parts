{ ... }: {

  flake.nixosModules.Steam = { pkgs, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        steam = prev.steam.override {
          extraArgs = "-cef-disable-gpu-compositing";
        };
      })
    ];

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      protontricks.enable = true;
    };

    programs.gamemode = {
      enable = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
