{ ... }:

{
  flake.nixosModules.AppArmor = { ... }: {
    security.apparmor = {
      enable = true;
      policies.node = {
        state = "enforce";
        profile = ''
          #include <tunables/global>

          /nix/store/*/bin/node {
            #include <abstractions/base>
            #include <abstractions/nameservice>

            /nix/store/** r,
            /nix/store/**/*.node m,
            /nix/store/**/bin/* ix,
            /nix/store/** m,

            /bin/sh ix,
            /usr/bin/env ix,
            /nix/store/*/bin/sh ix,
            /nix/store/*/bin/env ix,

            /home/zeaman/ r,
            /home/zeaman/** rwk,
            /home/zeaman/**/*.node m,
            /home/zeaman/**/node_modules/.bin/** ix,

            /tmp/** rwk,
            /tmp/**/*.node m,
            /run/user/**/ rw,

            /dev/null rw,
            /dev/urandom r,
            /dev/tty rw,
            /dev/pts/* rw,
            /proc/**/cgroup r,
            /sys/devices/system/cpu/cpufreq/** r,

            deny /{var/lib/sops-nix,etc/ssh,run/secrets,run/secrets-for-users}/** rw,
            deny /home/zeaman/.{config/{sops,age},ssh}/** rw,

            network inet stream,
            network inet6 stream,
            network unix stream,
          }
        '';
      };
    };
  };
}
