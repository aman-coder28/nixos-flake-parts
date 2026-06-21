{ pkgs, ... }:
{
  flake.homeMoodule.zeamanHomeConfig = { pkgs, }: {
    home.username = "zeaman";
    home.homeDirectory = "/home/zeaman";
    home.stateVersion = "24.05";

    programs.kitty = {
      enable = true;
      font = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
        size = "15";
      };
    };

    programs.home-manager.enable = true;
  };
}
