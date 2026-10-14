{ ... }: {

  flake.nixosModules.zeamanMachineHardware =
    {
      modulesPath,
      lib,
      config,
      ...
    }:
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:

    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/7ac69184-ec33-4838-b44a-dd8bbcbadb6d";
        fsType = "btrfs";
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/7ac69184-ec33-4838-b44a-dd8bbcbadb6d";
        fsType = "btrfs";
        options = [ "subvol=home" ];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/7ac69184-ec33-4838-b44a-dd8bbcbadb6d";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/ED1A-D75B";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/e5bfaa7a-fb6f-45af-8eb0-3035e11de413"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
