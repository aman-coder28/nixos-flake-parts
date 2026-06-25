{ self, ... }:
{
  flake.homeModules.zeamanHomeConfig = { ... }: {
    home.username = "zeaman";
    home.homeDirectory = "/home/zeaman";

    imports = [
      self.homeModules.ZedConfig
      self.homeModules.VSCodeConfig
    ];

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    home.stateVersion = "26.11";
    programs.home-manager.enable = true;
  };
}
