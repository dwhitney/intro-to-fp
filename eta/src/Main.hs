module Main where

import Day1

main :: IO ()
main = do
  putStrLn $ (foo "Hello, Eta!")
  putStrLn $ (show $ foo 10)

