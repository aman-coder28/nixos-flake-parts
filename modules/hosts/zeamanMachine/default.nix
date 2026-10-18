{ self, inputs, ... }: {
  flake.nixosConfigurations.zeamanuelMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.zeamanuelMachineConfig
      self.nixosModules.zeamanuelMachineHardware
      self.nixosModules.Settings
      self.nixosModules.Services
      self.nixosModules.SysPackages
      self.nixosModules.Security
      inputs.noctalia.nixosModules.default
      {
        nixpkgs.overlays = [
          inputs.helium-flake.overlays.default
        ];
      }
    ];
  };
}
