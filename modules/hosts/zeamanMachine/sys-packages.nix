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

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.git = {
      enable = true;
      config = {
        credential.helper = "manager";
        credential.credentialStore = "cache";
      };
    };

    programs.starship.enable = true;
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      gtk4
      gtksourceview5
      poppler
      glib
      cairo
      pango
      gdk-pixbuf
      fontconfig
      graphene
      harfbuzz
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      libadwaita
      libxcb

      wayland
      libxkbcommon
      vulkan-loader
      libGL
      fontconfig
      freetype
      openssl
      zlib
    ];
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
      git-credential-manager
      forgejo-cli
      nodejs_latest
      pnpm
      gcc
      jdk25
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
      devenv
      nixfmt-tree
      nix-search-tv
      nixfmt-rs
      fzf
      ripgrep
      nixfmt
      nixfmt-tree
      dnsmasq
      qemu

      hyprpicker
      hyprland-qt-support
      hyprland-qtutils
      hypridle
      # noctalia
      noctalia-greeter

      quickshell
      qt6.qtdeclarative
      qt6.qtmultimedia
      qt5.qtgraphicaleffects
      qt6.qtsvg
      qt6.qt5compat

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
      keyd

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
      emojify

      helium
      # librewolf
      opencode-desktop
      libreoffice
    ];

    fonts.packages = with pkgs; [
      jetbrains-mono
      fira-code
      fira-code-symbols
      inter
      roboto
      roboto-mono
    ];
  };
}
