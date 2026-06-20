{ self, inputs, ... }: {
  flake.nixosConfigurations.zeamanMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.zeamanMachineConfig
    ];
  };
}
