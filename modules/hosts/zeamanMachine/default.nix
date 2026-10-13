{ self, inputs, ... }: {
  flake.nixosConfigurations.zeamanMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.zeamanMachineConfig
      self.nixosModules.zeamanMachineHardware
      self.nixosModules.Settings
      self.nixosModules.Services
      self.nixosModules.SysPackages
      self.nixosModules.Security
      {
        nixpkgs.overlays = [
          inputs.helium-flake.overlays.default
        ];
      }
    ];
  };
}
