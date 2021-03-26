module RayTracer (generateTrace, main) where

import Arithmics
import Codec.Picture
import Codec.Picture.Types
import System.Environment
import Graphics.Gloss
import Graphics.Gloss.Juicy

width :: Int
width = 800

height :: Int
height = 600

generateTrace :: DynamicImage
--generateTrace = ImageRGB8 (generateImage traceRay width height)
--generateTrace = ImageRGB8 (generateImage nicePaper width height)
generateTrace = ImageRGB8 (generateImage traceSphereRay width height)

traceRay :: Int -> Int -> PixelRGB8
traceRay px py =
  if 300 < px && px < 500 && 200 < py && py < 400
  then PixelRGB8 255 128 128
  else PixelRGB8 128 255 128

nicePaper :: Int -> Int -> PixelRGB8
nicePaper px py =
  if (mod px 20 == 0) || (mod py 20 == 0)
  then PixelRGB8 200 250 255
  else PixelRGB8 255 255 255

traceSphereRay :: Int -> Int -> PixelRGB8
traceSphereRay px py =
  case reflectedColor3D line of
    SkyColor -> PixelRGB8 200 230 255
    DarkColor -> PixelRGB8 80 0 0
    BrightColor -> PixelRGB8 255 255 240
  where
    x = ((fromIntegral px) - 400.0)/200.0
    y = (300.0 - (fromIntegral py))/200.0
    lookLine = lineFrom (Vector3D 0 0 1) (Vector3D x 3 y)
    line = reflectedLine3D sphere lookLine

showPicture :: Picture -> IO ()
showPicture picture = display (InWindow "Ray Tracing Fun" (width, height) (0, 0)) white picture

{- }
animatePicture :: (Float -> Picture) -> IO()
animatePicture anim = animate (InWindow "Ray Animation" (width, height) (0, 0) white anim)

--Convert an animation to the format expected by Gloss
doIt :: Float -> Picture
doIt anim f = convCurve (anim (oscilate f))

--Input time in seconds and output is a function that oscillates between 0 and 1
oscilate :: Float -> Float
oscilate f = 0.5 + 0.5 * (sin f)
{ -}

main :: IO ()
main = case fromDynamicImage generateTrace of
  Just picture -> showPicture picture
  Nothing -> putStrLn "Cannot show picture"
