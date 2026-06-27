{ ... }: {
  flake.nixosModules.AppArmor = { ... }: {
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
  };
}
