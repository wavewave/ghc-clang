let
  pkgs = import <nixpkgs> {
    overlays = [
      (final: prev:
        let myStdenv = prev.llvmPackages_12.stdenv;
        in {
          haskellPackages = prev.haskell.packages.ghc8107.override {
            ghc = prev.buildPackages.haskell.compiler.ghc8107.override {
              useLLVM = true;
              llvmPackages = prev.llvmPackages_12;
              targetPackages = prev.targetPackages.extend
                (self: super: { stdenv = myStdenv; });
              pkgsHostTarget = prev.pkgsHostTarget.extend (self: super: {
                targetPackages = super.targetPackages.extend
                  (sself: super: { stdenv = myStdenv; });
              });
              pkgsBuildTarget = prev.pkgsBuildTarget.extend (self: super: {
                targetPackages = super.targetPackages.extend
                  (sself: super: { stdenv = myStdenv; });
              });
            };
            stdenv = myStdenv;
          };
        })
    ];
  };
  hsenv = pkgs.haskellPackages.ghcWithPackages (p: [ p.template-haskell ]);
in (pkgs.mkShell.override { stdenv = pkgs.clangStdenv; }) {

  buildInputs = [ hsenv ];
}
