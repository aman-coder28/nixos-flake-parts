{ self, ... }: {
  flake.nixosModules.Security = { ... }: {
    imports = [
      self.nixosModules.AppArmor
    ];

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        3000
        5432
        3306
        8000
      ];
      allowedTCPPortRanges = [
        # KDE Connect
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        # KDE Connect
        {
          from = 1714;
          to = 1764;
        }
      ];
      logRefusedConnections = true;
    };

    security.sudo = {
      enable = true;
      wheelNeedsPassword = true;
      execWheelOnly = true;
    };

    boot.loader.systemd-boot.editor = false;

    boot.kernel.sysctl = {
      # Network
      "net.ipv4.tcp_syncookies" = 1;
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.all.accept_source_route" = 0;

      # App Armor
      "apparmor" = 1;

      # Memory
      "kernel.kptr_restrict" = 2;
      "kernel.dmesg_restrict" = 1;
      "kernel.unprivileged_bpf_disabled" = 1;
      "net.core.bpf_jit_harden" = 2;
      "kernel.yama.ptrace_scope" = 2;
    };
  };
}
