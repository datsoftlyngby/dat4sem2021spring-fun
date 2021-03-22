module Main where

main :: IO ()
main = do
  name <- getLine
  putStrLn ("Hello "++name)

-- >>=

-- --> IO ()
-- getLine -> IO String
-- (<-) :: IO String -> IO ()
-- putStrLn :: String -> IO ()
