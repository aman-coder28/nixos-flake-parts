{ ... }: {

  flake.nixosModules.zeamanMachineConfig = { pkgs, lib, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.timeout = 2;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.initrd = {
      verbose = false;
      systemd.services.plymouth-start = {
        after = [ "systemd-modules-load.service" ];
        requires = [ "systemd-modules-load.service" ];
      };
    };

    boot = {
      kernelParams = [
        "quiet"
        "splash"
      ];

      consoleLogLevel = 3;

      plymouth = {
        enable = true;
        theme = "red_loader";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "red_loader" ];
          })
        ];
      };
    };

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

    nixpkgs.config.allowUnfree = true;

    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "tableplus"
      ];

    time.timeZone = "Africa/Nairobi";
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ALL = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
      LC_COLLATE = "en_US.UTF-8";
    };

    programs.fish.enable = true;

    sops.defaultSopsFile = "/home/zeaman/Code/projects/solid-tudos/.env.local";
    sops.defaultSopsFormat = "env";
    sops.age.keyFile = "/home/zeaman/.config/sops/age/keys.txt";

    users.users.zeaman = {
      isNormalUser = true;
      description = "ZeAman";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.fish;
    };
  };
}
