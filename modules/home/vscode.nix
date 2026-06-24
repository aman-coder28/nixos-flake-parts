{ ... }:
{
  flake.homeModules.vsCodeConfig = { ... }: {
    programs.vscode = {
      enable = true;

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
