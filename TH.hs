module TH where

import Language.Haskell.TH.Syntax
  ( Callconv (..),
    Dec (ForeignD),
    Foreign (ImportF),
    ForeignSrcLang (LangC),
    Q,
    Safety (Safe),
    Type (..),
    addForeignSource,
    mkName,
  )

myFunction :: Q [Dec]
myFunction = do
  addForeignSource
    LangC
    "#include <stdio.h>\n\
    \void test( void ) {\n\
    \  printf (\"clang version: %d\", __clang_major__);\n\
    \}\n"

  pure $
    [ ForeignD $
        ImportF CCall Safe "test" (mkName "c_test") (AppT (ConT (mkName "IO")) (TupleT 0))
    ]
