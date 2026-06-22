{ self, ... }:
{
  flake.homeModules.zeamanHomeConfig = { ... }: {
    home.username = "zeaman";
    home.homeDirectory = "/home/zeaman";

    imports = [
      self.homeModules.ZedConfig
      self.homeModules.AlacrittyConfig
    ];

    programs.cursor = {
      enable = true;
      mutableExtensionsDir = true;
      argvSettings = {
        enable-crash-reporter = false;
      };
    };

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    home.stateVersion = "26.11";
    programs.home-manager.enable = true;
  };
}
