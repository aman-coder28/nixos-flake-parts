{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
      self.packages.${pkgs.stdenv.hostPlatform.system}.tableplus
    ];
  };

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages = {
        myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
          inherit pkgs;
          package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

          settings = builtins.fromJSON (builtins.readFile ./noctalia.json);
        };

      };

    };
}
