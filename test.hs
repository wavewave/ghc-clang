{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import TH

$(myFunction)

main :: IO ()
main = do
  putStrLn
    "C code insertion using addForeignSource"
  c_test
