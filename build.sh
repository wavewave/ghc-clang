ghc -fforce-recomp -v -keep-tmp-files -ddump-splices test.hs

# custom c toolchain
# ghc -pgma clang -pgmc clang -fforce-recomp -v -keep-tmp-files -ddump-splices test.hs
