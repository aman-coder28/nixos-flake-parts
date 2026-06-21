{ ... }: {
  flake.homeModules.zeamanHomeConfig = { pkgs, ... }: {
    programs.zed-editor = {
      enable = true;

      defaultEditor = true;

      extensions = [
        "nix"
        "oxc"
        "tailwindcss"
        "emmet"
        "vue"
        "vscode-icons"
        # "tsgo"
      ];

      userSettings = {
        diff_view_style = "split";
        cli_default_open_behavior = "existing_window";
        git_panel = {
          dock = "left";
        };
        buffer_line_height = "comfortable";
        project_panel = {
          auto_fold_dirs = false;
          hide_hidden = true;
          dock = "left";
          hide_gitignore = true;
        };
        edit_predictions = {
          provider = "none";
        };
        show_edit_predictions = false;
        disable_ai = true;
        toolbar = {
          quick_actions = false;
          breadcrumbs = false;
        };
        show_wrap_guides = true;
        autoscroll_on_clicks = true;
        telemetry = {
          metrics = false;
        };
        format_on_save = "on";
        formatter = "language_server";
        ui_font_size = 16;
        ui_font_family = "Adwaita Sans";
        ui_font_weight = 300;
        buffer_font_size = 16.2;
        buffer_font_family = "JetBrains Mono";
        buffer_font_weight = 395;
        tab_size = 2;
        preferred_line_length = 110;
        soft_wrap = "bounded";
        icon_theme = "VSCode Icons for Zed (Dark)";
        session = {
          trust_all_worktrees = true;
        };
        theme = "One Dark";
        terminal = {
          dock = "bottom";
          shell = {
            program = "${pkgs.fish}/bin/fish";
          };
        };
        file_types = {
          "Git Config" = [
            "conf"
          ];
        };

        languages = {
          Rust = {
            hard_tabs = true;
            tab_size = 2;
          };
          TypeScript = {
            formatter = [
              {
                language_server = {
                  name = "oxfmt";
                };
              }
            ];
          };
          JavaScript = {
            formatter = [
              {
                language_server = {
                  name = "oxfmt";
                };
              }
            ];
          };
          TSX = {
            formatter = [
              {
                language_server = {
                  name = "oxfmt";
                };
              }
            ];
          };
          CSS = {
            formatter = [
              {
                language_server = {
                  name = "oxfmt";
                };
              }
            ];
          };
        };

        lsp = {
          vtsls = {
            enable_lsp_tasks = true;
          };
          oxlint = {
            initialization_options = {
              settings = {
                configPath = null;
                disableNestedConfig = false;
                fixKind = "safe_fix";
                run = "onType";
                typeAware = true;
                unusedDisableDirectives = "deny";
              };
            };
          };
          nixd = {
            binary.path = "${pkgs.nixd}/bin/nixd";

            settings = {
              nixpkgs = {
                expr = "import <nixpkgs> { }";
              };

              formatting = {
                command = [
                  "nixfmt"
                ];
              };

              options = {
                nixos = {
                  expr = "(builtins.getFlake (builtins.toString \"/etc/nixos\")).nixosConfigurations.zeaman.options";
                };
                home-manager = {
                  expr = "(builtins.getFlake (builtins.toString \"/etc/nixos\")).nixosConfigurations.zeaman.options.home-manager.users.type.getSubOptions []";
                };

                # flake-parts = {
                #   expr = "(builtins.getFlake \"/etc/nixos\").debug.options";
                # };
              };

              diagnostic = {
                suppress = [
                  "sema-extra-with"
                ];
              };
            };
          };

          nix = {
            binary = {
              path_lookup = true;
            };
          };
        };
      };

      mutableUserSettings = true;
      mutableUserKeymaps = true;
      mutableUserTasks = true;
    };
  };
}
