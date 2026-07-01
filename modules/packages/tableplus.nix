{
  lib,
  fetchurl,
  appimageTools,
  ...
}:

let
  version = "1.2.6";
  pname = "tableplus";

  src = fetchurl {
    url = "https://tableplus.com/release/linux/x64/TablePlus-x64.AppImage";
    hash = lib.fakeSha256;
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/tableplus.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/tableplus.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share 2>/dev/null || true
  '';

  meta = {
    description = "Modern, native, and friendly GUI tool for relational databases";
    homepage = "https://tableplus.com";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
