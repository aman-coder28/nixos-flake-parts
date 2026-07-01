{ inputs, ... }: {

  flake.nixosModules.Services = { pkgs, ... }: {
    services.displayManager.gdm = {
      enable = false;
    };
    services.desktopManager.gnome.enable = true;

    programs.noctalia-greeter = {
      enable = true;
      package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

      settings.cursor = {
        theme = "macOS";
        size = 24;
        package = pkgs.apple-cursor;
      };
    };

    services.clamav = {
      daemon.enable = true;
      updater.enable = true;
      scanner.enable = true;
      clamonacc.enable = true;

      daemon.settings = {
        OnAccessPrevention = true;
        OnAccessIncludePath = "/home/beaman/Downloads";
      };
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;
    powerManagement = {
      enable = true;
      powertop.enable = true;
    };
    services.upower.enable = true;
    hardware.bluetooth.enable = true;

    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureDatabases = [ "learning" ];
    };

    services.postgresql = {
      enable = true;
      ensureDatabases = [ "tudos" ];
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all      all     trust
        host  all      all     127.0.0.1/32   trust
        host  all      all     ::1/128        trust
      '';
      ensureUsers = [
        {
          name = "tudos";
          ensureDBOwnership = true;
          ensureClauses = {
            login = true;
            password = "password";
          };
        }
      ];
    };
  };
}
