let
  pkgs = import <nixpkgs> {
    overlays = [
      (final: prev: {
        haskellPackages = prev.haskell.packages.ghc8107.override {
          ghc = final.buildPackages.haskell.compiler.ghc8107.override {
            useLLVM = true;
          };
          stdenv = prev.clangStdenv;
        };
      })
    ];
  };
  hsenv = pkgs.haskellPackages.ghcWithPackages (p: [ p.template-haskell ]);
in (pkgs.mkShell.override { stdenv = pkgs.clangStdenv; }) {

  buildInputs = [ hsenv ];
}

#pkgs.clangStdenv.mkDerivation { name = "test-clangStdenv-shell"; }
