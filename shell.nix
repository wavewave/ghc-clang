let
  pkgs = import <nixpkgs> {
    overlays = [
      (final: prev: {
        #stdenv = prev.clangStdenv;
        #buildPackages =
        #  prev.buildPackages.override { stdenv = prev.clangStdenv; };
        haskellPackages =
          prev.haskell.packages.ghc8107.override { stdenv = prev.clangStdenv; };
      })
    ];
  };
  hsenv = pkgs.haskellPackages.ghcWithPackages (p: [ p.template-haskell ]);
in (pkgs.mkShell.override { stdenv = pkgs.clangStdenv; }) {

  buildInputs = [ hsenv ];
}

#pkgs.clangStdenv.mkDerivation { name = "test-clangStdenv-shell"; }
