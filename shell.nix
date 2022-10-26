{pkgs}: let
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      nodePackages.vscode-css-languageserver-bin
      elmPackages.elm
      elmPackages.elm-format
      elmPackages.elm-language-server
      nodePackages.webpack
      nodePackages.webpack-cli
      nodePackages.webpack-dev-server
    ];
    shellHook = ''
    '';
  }
