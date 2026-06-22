{ ... }: {

  flake.nixosModules.SysPackages = { pkgs, ... }: {
    programs.firefox.enable = true;
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    programs.starship.enable = true;
    programs.nix-ld.enable = true;
    programs.kdeconnect.enable = true;

    environment.shellAliases = {
      pn = "pnpm";
      pni = "pnpm install";
      pnx = "pnpm dlx";
    };

    environment.systemPackages = with pkgs; [
      git
      postgresql
      code-cursor
      ghostty
      alacritty
      zed-editor
      nodejs_latest
      pnpm
      bun
      gcc
      helium
      nixd
      nil
      nixfmt
      nixfmt-tree
      github-cli
      gparted
      xhost

      hypridle
      hyprlock
      mate-polkit
      pavucontrol
      proton-vpn
      xwayland-satellite
      transmission_4-qt6
      geary
      peazip
      nwg-look
      vlc
      amberol

      mariadb
      wl-clipboard
      cliphist
      pamixer
      brightnessctl
      blueman
      apple-cursor
      libnotify
      playerctl
      brave
      opencode-desktop
      font-awesome_6
      font-awesome_7

      libreoffice-fresh
      onlyoffice-desktopeditors
      beekeeper-studio
      # jetbrains.datagrip
    ];

    fonts.packages = with pkgs; [
      jetbrains-mono
      fira-code
      fira-code-symbols
      inter
    ];
  };
}
