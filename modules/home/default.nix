{ ... }:
{
  flake.homeModules.zeamanHomeConfig = { pkgs }: {
    home.username = "zeaman";
    home.homeDirectory = "/home/zeaman";

    programs.kitty = {
      enable = true;
      font = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
        size = "15";
      };
    };

    home.stateVersion = "26.11";
    programs.home-manager.enable = true;
  };
}
