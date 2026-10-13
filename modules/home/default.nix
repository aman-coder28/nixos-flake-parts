{ self, ... }:
{
	flake.homeConfigurations = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      modules = [
       	{
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs; };
          backupFileExtension = "backup";
          users.zeaman = self.homeModules.zeamanHomeConfig;
        };
      ];
    };
  };
}
