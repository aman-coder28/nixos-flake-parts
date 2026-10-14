{ self, ... }:
{
  flake.homeModules.zeamanuelHomeConfig = { ... }: {
    home.username = "zeamanuel";
    home.homeDirectory = "/home/zeamanuel";

    home.useGlobalPkgs = true;
    home.useUserPackages = true;
    home.backupFileExtension = "backup";

    imports = [
      self.homeModules.ZedConfig
    ];

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    home.stateVersion = "26.11";
    programs.home-manager.enable = true;
  };
}
