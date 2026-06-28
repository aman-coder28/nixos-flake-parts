{
  flake.homeModules.VSCodeConfig = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      profiles = {
        default = {
          extensions = with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
            oxc.oxc-vscode
            vscode-icons-team.vscode-icons
            vue.volar
          ];

          userSettings = (builtins.fromJSON (builtins.readFile ./cursor-settings.json)) // {
            "workbench.colorTheme" = "Cursor Dark Core";
            "workbench.iconTheme" = "vscode-icons";
            "workbench.activityBar.location" = "top";
            "workbench.sideBar.location" = "left";
            "window.commandCenter" = true;

            "editor.stickyScroll.enabled" = false;
            "editor.formatOnSave" = true;
            "editor.fontSize" = 16.5;
            "editor.fontFamily" = "jetbrains mono";
            "editor.wordWrap" = "bounded";
            "editor.wordWrapColumn" = 100;
            "editor.tabSize" = 2;
            "editor.formatOnPaste" = true;
            "editor.fontLigatures" = true;
            "editor.fontWeight" = "335";
            "editor.defaultFormatter" = "oxc.oxc-vscode";
            "editor.bracketPairColorization.enabled" = false;
            "editor.guides.bracketPairsHorizontal" = false;
            "editor.guides.highlightActiveBracketPair" = false;
            "breadcrumbs.enabled" = false;

            "telemetry.telemetryLevel" = "off";
          };
          enableExtensionUpdateCheck = true;
          enableUpdateCheck = true;
        };
      };
      mutableExtensionsDir = true;
    };
  };
}
