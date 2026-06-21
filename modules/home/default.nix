{ ... }:
{
  flake.homeModules.zeamanHomeConfig = { ... }: {
    home.username = "zeaman";
    home.homeDirectory = "/home/zeaman";

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    home.stateVersion = "26.11";
    programs.home-manager.enable = true;
  };
}
