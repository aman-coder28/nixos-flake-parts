{ ... }:
{
  flake.homeModules.vsCodeConfig = { pkgs, ... }: {
    programs.vscode = {
      package = pkgs.code-cursor;
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        mtxr.sqltools
        mtxr.sqltools-driver-pg
        mtxr.sqltools-driver-mysql
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
       {
          name = "cursor-theme-vscode";
          publisher = "BioHazard786";
          version = "1.0.0";
          sha256 = lib.fakeSha256;
        }
      ];

      userSettings = (builtins.fromJSON (builtins.readFile ./cursor-settings.json)) // {
        "workbench.colorTheme" = "Cursor Dark";
        "workbench.activityBar.location" = "default";
        "workbench.sideBar.location" = "left";
        "editor.minimap.enabled" = false;
        "window.commandCenter" = false;
        "github.copilot.enable" = { "*" = false; };
        "telemetry.telemetryLevel" = "off";
      };

      mutableExtensionsDir = true;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
    };
  };
}
