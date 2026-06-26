{ ... }: {

  flake.nixosModules.Security = { ... }: {
    security.apparmor = {
      enable = true;
      killUnconfinedConfinables = false;

      # security.nix
      security.apparmor = {
        enable = true;
        policies = {
          "node" = {
            enable = true;
            enforce = true;
            profile = ''
              #include <tunables/global>
              /nix/store/*/bin/node {
                #include <abstractions/base>

                # Allow project directory
                /home/zeaman/Code/** rw,

                # Allow Nix store (read only)
                /nix/store/** r,

                # Explicitly DENY sensitive paths
                deny /home/zeaman/.config/sops/** rwx,
                deny /home/zeaman/.ssh/** rwx,
                deny /run/secrets/** rwx,
                deny /home/zeaman/.config/age/** rwx,

                # Network
                network inet stream,
                network inet6 stream,
              }
            '';
          };
        };
      };
    };

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        3000
        5432
        3306
        8000
      ];
      allowedTCPPortRanges = [
        1714
        1764
      ];
      allowedUDPPortRanges = [
        1714
        1764
      ];
      logRefusedConnections = true;
    };

    services.resolved = {
      enable = true;
      dnssec = "true";
      dnsovertls = "true";
    };

    security.sudo = {
      enable = true;
      wheelNeedsPassword = true;
      execWheelOnly = true;
    };

    boot.loader.systemd-boot.editor = false;
    boot.loader.timeout = 5;

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

      # Memory
      "kernel.kptr_restrict" = 2;
      "kernel.dmesg_restrict" = 1;
      "kernel.unprivileged_bpf_disabled" = 1;
      "net.core.bpf_jit_harden" = 2;
      "kernel.yama.ptrace_scope" = 2;
    };
  };
}
