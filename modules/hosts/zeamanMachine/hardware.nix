{ ... }: {

  flake.nixosModules.zeamanMachineHardware =
    {
      modulesPath,
      lib,
      config,
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
        device = "/dev/disk/by-uuid/8df9c997-a866-47f7-b836-18f1ec87a19d";
        fsType = "btrfs";
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/8df9c997-a866-47f7-b836-18f1ec87a19d";
        fsType = "btrfs";
        options = [ "subvol=home" ];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/8df9c997-a866-47f7-b836-18f1ec87a19d";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/B3D2-A7C6";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      fileSystems."/storage" = {
        device = "/dev/disk/by-uuid/f8ec499f-7b7d-45c8-a7ef-91e3732eb08b";
        fsType = "btrfs";
        options = [
          "compress=zstd"
          "noatime"
        ];
      };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
