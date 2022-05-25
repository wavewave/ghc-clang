module TH where

import Language.Haskell.TH.Syntax
  ( Exp (TupE),
    ForeignSrcLang (LangC),
    Q,
    addForeignSource,
  )

myFunction :: Q Exp
myFunction = do
  addForeignSource
    LangC
    "#include <stdio.h>\n\
    \void test( void ) {\n\
    \  printf (\"xyz\");\n\
    \}\n"
  return (TupE [])
