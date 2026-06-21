{ self, inputs, ... }: {
  flake.nixosConfigurations.zeamanMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.zeamanMachineConfig
      self.nixosModules.zeamanMachineHardware
      self.nixosModules.Settings
      self.nixosModules.Services
      self.nixosModules.SysPackages
      self.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      {
        nixpkgs.overlays = [
          inputs.helium-flake.overlays.default
        ];
      }
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs; };
          users.zeaman = self.homeModules.zeamanHomeConfig;
        };
      }
    ];
  };
}
