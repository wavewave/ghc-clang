{-# LANGUAGE TemplateHaskell #-}

module Main where

import TH

main :: IO ()
main = do
  pure $(myFunction)
  putStrLn
    "hello world"
