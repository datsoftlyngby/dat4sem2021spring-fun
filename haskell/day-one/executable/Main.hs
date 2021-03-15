-- It is generally a good idea to keep all your business logic in your library
-- and only use it in the executable. Doing so allows others to use what you
-- wrote in their libraries.
import qualified Example
import qualified Hello

import Arithmics
import Codec.Picture
import Codec.Picture.Types
import System.Environment

width :: Int
width = 800

height :: Int
height = 600

generateTrace :: DynamicImage
generateTrace = ImageRGB8 (generateImage traceRay width height)

traceRay :: Int -> Int -> PixelRGB8
traceRay px py =
  if 300 < px && px < 500 && 200 < py && py < 400
  then PixelRGB8 255 128 128
  else PixelRGB8 128 255 128


main :: IO ()
main = do
  putStrLn "Starting trace ..."
  savePngImage "hello.png" generateTrace
  putStrLn "Done!"


  {-
  putStrLn "What is your name?"
  name <- getLine
  putStrLn ( Hello.greet name )
  -}

-- main = Example.main
