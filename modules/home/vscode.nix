{ ... }:
{
  flake.homeModules.vsCodeConfig = { ... }: {
    programs.vscode = {
      enable = true;
      userSettings = builtins.fromJSON (builtins.readFile ./cursor-settings.json);

      mutableExtensionsDir = true;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
    };
  };
}
