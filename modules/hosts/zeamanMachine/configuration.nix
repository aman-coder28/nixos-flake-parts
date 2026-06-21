{ self, inputs, ... }: {

  flake.nixosModules.zeamanMachineConfig = { pkgs, ... }: {
    imports = [
      self.nixosModules.zeamanMachineHardware
      self.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs; };
          users.zeaman = self.homeModules.zeamanHomeConfig;
        };
      }
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_zen;

    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 8 * 1024;
      }
    ];

    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 50;
    };

    networking.hostName = "zeamanMachine";
    networking.networkmanager.enable = true;

    time.timeZone = "Africa/Nairobi";
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ALL = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF8";
      LC_ADDRESS = "es_VE.UTF-8";
      LC_IDENTIFICATION = "es_VE.UTF-8";
      LC_MEASUREMENT = "es_VE.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_MONETARY = "es_VE.UTF-8";
      LC_NAME = "es_VE.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "es_VE.UTF-8";
      LC_TELEPHONE = "es_VE.UTF-8";
      LC_TIME = "es_VE.UTF-8";
      LC_COLLATE = "es_VE.UTF-8";
    };

    programs.fish.enable = true;
    # programs.firefox.enable = true;
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    programs.starship.enable = true;

    environment.systemPackages = with pkgs; [
      kitty
    ];

    users.users.zeaman = {
      isNormalUser = true;
      description = "ZeAman";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.fish;
    };

    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
      trusted-substituters = [
        "https://noctalia.cachix.org"
      ];
    };

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    nix.optimise = {
      automatic = true;
      dates = "03:45";
    };

    fonts.packages = with pkgs; [
      jetbrains-mono
      fira-code
      fira-code-symbols
      inter
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    system.stateVersion = "26.11";
  };
}
