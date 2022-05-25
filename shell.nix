let
  pkgs = import <nixpkgs> {
    overlays = [
      (final: prev: {
        haskellPackages = prev.haskell.packages.ghc8107.override {
          ghc = final.buildPackages.haskell.compiler.ghc8107.override {
            useLLVM = true;
            stdenv = prev.clangStdenv;
            llvmPackages = final.llvmPackages_12;
            targetPackages = prev.targetPackages.extend
              (self: super: { stdenv = prev.clangStdenv; });
            pkgsHostTarget = prev.pkgsHostTarget.extend (self: super: {
              targetPackages = super.targetPackages.extend
                (sself: super: { stdenv = prev.clangStdenv; });
            });
            pkgsBuildTarget = prev.pkgsBuildTarget.extend (self: super: {
              targetPackages = super.targetPackages.extend
                (sself: super: { stdenv = prev.clangStdenv; });
            });
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
