{ self, ... }:
{
  flake.homeModules.zeamanuelHomeConfig =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      home.username = "zeamanuel";
      home.homeDirectory = "/home/zeamanuel";
      home.backupFileExtension = "backup";

      imports = [
        self.homeModules.ZedConfig
      ];

      programs.starship = {
        enable = true;
        enableFishIntegration = true;
      };

      home.activation.syncDotfiles =
        let
          repo = "${config.home.homeDirectory}/Code/config/nixos-flake-parts";
        in
        lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          run mkdir -p ${repo}/modules/home/_dotfiles
          run ${pkgs.rsync}/bin/rsync -avL \
            --include-from=${repo}/modules/home/create_include.txt \
            --exclude='*' \
            ${config.home.homeDirectory}/.config/ \
            ${repo}/modules/home/_dotfiles/ \
            || echo "warning: dotfile sync failed" >&2
        '';

      home.stateVersion = "26.11";
      programs.home-manager.enable = true;
    };
}
