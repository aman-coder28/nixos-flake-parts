{ ... }: {

  flake.nixosModules.zeamanMachineConfig = { ... }: {
    services.xserver.enable = true;
    services.displayManager.gdm = {
      enable = true;
    };
    services.desktopManager.gnome.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
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
  };
}
