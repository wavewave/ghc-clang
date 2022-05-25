{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import TH

foreign import ccall "test" c_test :: IO ()

main :: IO ()
main = do
  pure $(myFunction)
  putStrLn
    "hello world"
  c_test
