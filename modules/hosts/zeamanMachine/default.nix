{ self, inputs, ... }: {
  flake.nixosConfigurations.zeamanMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.zeamanMachineConfig
      self.nixosModules.zeamanMachineHardware
      self.nixosModules.Settings
      self.nixosModules.Services
      self.nixosModules.SysPackages
      self.nixosModules.Security
      # self.nixosModules.Steam
      self.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
      inputs.sops-nix.nixosModules.sops
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
          backupFileExtension = "backup";
          users.zeaman = self.homeModules.zeamanHomeConfig;
        };
      }
    ];
  };
}
