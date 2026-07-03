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
      vscode
      nodejs_latest
      glibc
      pnpm
      gcc
      # clang
      # clang-tools
      go
      gopls
      helium
      nixd
      nil
      nixfmt
      nixfmt-tree
      gh
      gparted
      xhost

      hypridle
      fastfetch
      hyprlock
      mate-polkit
      pavucontrol
      proton-vpn
      xwayland-satellite
      transmission_4-qt6
      sops
      geary
      peazip
      nwg-look
      vlc
      amberol
      clamav
      clamtk

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
    ];

    fonts.packages = with pkgs; [
      jetbrains-mono
      fira-code
      fira-code-symbols
      inter
    ];
  };
}
