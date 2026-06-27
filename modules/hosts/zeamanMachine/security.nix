{ ... }: {

  flake.nixosModules.Security = { ... }: {
    security.apparmor = {
      enable = true;
      killUnconfinedConfinables = false;

      policies = {
        "node" = {
          state = "enforce";
          profile = ''
            #include <tunables/global>
            /nix/store/*/bin/node {
              #include <abstractions/base>

              /nix/store/** rm,
              /nix/store/** r,
              /nix/store/**/*.node m,
              /nix/store/**/bin/* ix,
              /nix/store/**/lib/*.so* m,

              # Shebang interpreters
              /bin/sh ix,
              /bin/bash ix,
              /usr/bin/env ix,
              /usr/bin/env/** ix,

              # Nix store shells (shebangs resolve to these)
              /nix/store/*/bin/sh ix,
              /nix/store/*/bin/bash ix,
              /nix/store/*/bin/env ix,
              /nix/store/*/bin/node ix,

              /usr/bin/node mr,
              /usr/lib/node_modules/** r,
              /usr/share/nodejs/** r,

              # ─── Your project directories (allow read + mmap) ───
              /home/zeaman/Code/** rwk,        # rwk = read, write, lock
              /home/zeaman/Code/**/*.node m,    # critical: allow mmap for native bindings

              /home/**/node_modules/.bin/** ix,
              /home/**/.pnpm/**/node_modules/.bin/** ix,

              # ─── pnpm store (where .node files are cached) ───
              /home/zeaman/.local/share/pnpm/** r,
              /home/zeaman/.local/share/pnpm/**/*.node m,

              # ─── Global node_modules (if using npx/global tools) ───
              /home/zeaman/.local/lib/node_modules/** rw,
              /home/zeaman/.local/lib/node_modules/**/*.node m,
              /home/zeaman/.npm-global/** r,
              /home/zeaman/.npm-global/**/*.node m,
              /home/zeaman/.npm-global/**/node_modules/.bin/** ix,

              /home/zeaman/.cursor/extensions/** rw,
              /home/zeaman/.cursor/extensions/**/*.node m,

              /home/zeaman/.vscode/extensions/** rw,
              /home/zeaman/.vscode/extensions/**/*.node rw,

              /home/zeaman/.local/share/zed/** rw,
              /home/zeaman/.local/share/zed/**/*.node m,

              # ─── /tmp for build artifacts ───
              /tmp/** rw,
              /tmp/**/*.node m,

              # Explicitly DENY sensitive paths
              deny /home/zeaman/.config/sops/** rwx,
              deny /home/zeaman/.ssh/** rwx,
              deny /run/secrets/** rwx,
              deny /home/zeaman/.config/age/** rwx,

              network inet stream,
              network inet6 stream,
              network inet dgram,
              network inet6 dgram,
              network unix stream,
              network unix dgram,
            }
          '';
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

    # services.resolved = {
    #   enable = true;
    #   dnssec = "true";
    #   dnsovertls = "true";
    # };

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
