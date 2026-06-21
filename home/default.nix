{ inputs, ... }: {
  flake.homeConfigurations.zeamanHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [
      inputs.self.homeModules.zeamanHome
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home.username = "zeaman";
        home.homeDirectory = "/home/zeaman";
        home.stateVersion = "26.11";
      }
    ];
  };
}
