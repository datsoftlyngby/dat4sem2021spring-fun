module Arithmics where

data Vector3D = Vector3D
  { x :: Float
  , y :: Float
  , z :: Float
  } deriving (Show)

add3D :: Vector3D -> Vector3D -> Vector3D
add3D (Vector3D x1 y1 z1) (Vector3D x2 y2 z2) =
  Vector3D (x1 + x2) (y1 + y2) (z1 + z2)

sub3D :: Vector3D -> Vector3D -> Vector3D
sub3D (Vector3D x1 y1 z1) (Vector3D x2 y2 z2) =
  Vector3D (x1 - x2) (y1 - y2) (z1 - z2)

mul3D :: Vector3D -> Float -> Vector3D
mul3D (Vector3D x1 y1 z1) f =
  Vector3D (f*x1) (f*y1) (f*z1)

dot3D :: Vector3D -> Vector3D -> Float
dot3D (Vector3D x1 y1 z1) (Vector3D x2 y2 z2) =
  x1*x2 + y1*y2 + z1*z2

size3D :: Vector3D -> Float
size3D v = sqrt (dot3D v v)
-- size3D (Vector3D x' y' z') = sqrt (x'**2 + y'*y' + z'**2)

data Line3D = Line3D
  { origo :: Vector3D
  , unit :: Vector3D
  } deriving (Show)

data Sphere3D = Sphere3D
  { center :: Vector3D
  , radius :: Float
  }

eye :: Vector3D
eye = Vector3D 0 0 0

lineFrom :: Vector3D -> Vector3D -> Line3D
lineFrom o t = Line3D o u where
  v = sub3D t o -- find vector from o to t : t - o
  u = mul3D v (1.0/size3D v)

-- intersectDistance :: Sphere3D -> Line3D -> Maybe Float
