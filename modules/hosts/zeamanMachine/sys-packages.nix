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
      kitty
      ghostty
      alacritty
      zed-editor
      vscode

      git
      gh
      forgejo-cli
      nodejs_latest
      pnpm
      gcc
      cmake
      llvmPackages_23.clang
      llvmPackages_23.clang-tools
      go
      gopls
      podman

      bat
      eza
      atuin
      nixd
      nil
      nixfmt
      nixfmt-tree

      hyprland
      hyprpicker
      hyprland-qt-support
      xdg-desktop-portal-hyprland
      hyprland-qtutils
      hypridle
      noctalia
      noctalia-greeter
      niri

      quickshell
      qt6.qtdeclarative
      qt6.qtmultimedia
      qt5.qtgraphicaleffects
      qt6.qtsvg

      xwayland-satellite
      mate-polkit
      nwg-look
      pavucontrol
      wl-clipboard
      cliphist
      pamixer
      brightnessctl
      blueman
      btop

      apple-cursor
      libnotify
      playerctl
      fastfetch
      grim
      slurp
      swappy
      cava

      proton-vpn
      transmission_4-gtk
      resources
      geary
      peazip
      vlc
      gparted
      xhost
      amberol
      gpu-screen-recorder
      clamav
      clamtk

      helium
      opencode-desktop
      libreoffice-fresh
    ];

    fonts.packages = with pkgs; [
      jetbrains-mono
      fira-code
      fira-code-symbols
      inter
    ];
  };
}
