{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      system,
      ...
    }:
    let
      version = "1.2.6";
      pname = "tableplus";

      src = pkgs.fetchurl {
        url = "https://tableplus.com/release/linux/x64/TablePlus-x64.AppImage";
        hash = "sha256-3AaL3BIGYbJdFDPE08Npuy1fLlr35+USOCHRNMYYaTU=";
      };

      appimageContents = pkgs.appimageTools.extractType2 { inherit pname version src; };
    in
    {

      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;

          allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "tableplus" ];
        };
      };

      packages = {
        tableplus = pkgs.appimageTools.wrapType2 {
          inherit pname version src;

          extraPkgs =
            pkgs: with pkgs; [
              # Core libs
              libidn2
              libunistring
              gnutls
              glib-networking
              libsecret

              # GTK/GDK
              gtk3
              gtk3-x11
              gdk-pixbuf
              pango
              cairo
              atk
              at-spi2-atk
              at-spi2-core

              # X11/Wayland
              libglvnd
              libdrm
              mesa
              vulkan-loader
              libX11
              libXcomposite
              libXdamage
              libXext
              libXfixes
              libXi
              libXrandr
              libXrender
              libXtst
              libxcb
              libxkbfile
              libxshmfence
              libXcursor
              libXinerama
              libXScrnSaver
              libxkbcommon

              # Networking/Security
              nspr
              nss
              cups
              libgcrypt
              openssl

              # Media
              alsa-lib
              ffmpeg
              libopus

              # Theming
              adwaita-icon-theme
              gnome-themes-extra
              hicolor-icon-theme

              # DBus
              dbus
              dbus-glib

              # Misc
              expat
              libuuid
              util-linux
              zlib
              zstd
            ];

          extraInstallCommands = ''
            install -m 444 -D ${appimageContents}/tableplus-appimage.desktop -t $out/share/applications
            for desktopFile in $out/share/applications/*.desktop; do
                substituteInPlace "$desktopFile" \
                  --replace-fail 'Exec=AppRun' 'Exec=${pname}' \
                  --replace-fail 'Exec=AppRun --no-sandbox' 'Exec=${pname}' \
                  2>/dev/null || true
              done

              cp -r ${appimageContents}/usr/share/icons $out/share 2>/dev/null || true
              cp -r ${appimageContents}/usr/share/icons/hicolor $out/share/icons 2>/dev/null || true
          '';

          meta = {
            description = "Modern, native, and friendly GUI tool for relational databases";
            homepage = "https://tableplus.com";
            license = pkgs.lib.licenses.unfree;
            platforms = [ "x86_64-linux" ];
          };
        };
      };
    };
}
