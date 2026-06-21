{ ... }: {
  flake.homeModules.zeamanHome = { ... }: {
    programs.kitty = {
      enable = true;
    };
  };
}
