{ self, ... }: {

  flake.nixosModules.zeamanMachineConfig = { pkgs, lib, ... }: {
    imports = [
      # self.nixosModules.zeamanMachineHardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
