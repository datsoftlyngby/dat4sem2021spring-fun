-- It is generally a good idea to keep all your business logic in your library
-- and only use it in the executable. Doing so allows others to use what you
-- wrote in their libraries.
import qualified Example
import qualified Hello

main :: IO ()
main = do
  putStrLn "What is your name?"
  name <- getLine
  putStrLn ( Hello.greet name )

-- main = Example.main
