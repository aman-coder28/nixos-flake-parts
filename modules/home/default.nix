{ self, inputs, ... }:
{
  flake.homeConfigurations.zeaman = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

    extraSpecialArgs = { inherit inputs; };

    modules = [ self.homeModules.zeamanHomeConfig ];
  };
}
