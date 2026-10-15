{ ... }: {
  flake.nixosModules.SysPackages = { pkgs, ... }: {
    programs.firefox.enable = true;
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    programs.atuin = {
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
      pkg-config
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

      hyprpicker
      hyprland-qt-support
      hyprland-qtutils
      hypridle
      noctalia
      noctalia-greeter

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
      emojify
      gnome-mahjongg
      localsend
      opencode-desktop
      opencode
      refine
      brave
      bazaar
      authenticator
      discord
      proton-vpn
      proton-pass
      resources
      amberol
      gpu-screen-recorder
      clamav
      clamtk

      helium
      opencode-desktop
      libreoffice
    ];

    fonts.packages = with pkgs; [
      jetbrains-mono
      fira-code
      fira-code-symbols
      inter
    ];
  };
}
