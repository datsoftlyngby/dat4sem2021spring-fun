module World where

import Linear (V3)

class Traceable t where
  trace :: Ray -> t -> Ray

data World = World
  { things :: [Thing]

  }

data Thing
  = Sphere { center :: V3 Float, radius :: Float }
  | Cube { origo :: V3 Float, size :: V3 Float }

instance Traceable Thing where


data Ray = Ray
  { source :: V3 Float
  , unit :: V3 Float
  , distance :: Float
  }
