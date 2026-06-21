{ ... }: {
  flake.homeModules.AlacrittyConfig = { pkgs, ... }: {
    programs.alacritty = {
      enable = true;
      theme = "one_dark";
      themePackage = pkgs.alacritty-theme;

      settings = {
        window = {
          padding = {
            x = 12;
            y = 12;
          };
          decorations = "Full";
          opacity = 1;
        };
        font = {
          normal = {
            family = "JetBrains Mono";
            style = "Regular";
          };
          size = 12;
        };
        terminal.shell = {
          program = "${pkgs.fish}/bin/fish";
        };
        cursor.style = {
          shape = "Block";
          blinking = "On";
        };
      };
    };
  };
}
