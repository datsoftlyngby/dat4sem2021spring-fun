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

size3D :: Vector3D -> Float
size3D (Vector3D x' y' z') = sqrt (x'**2 + y'*y' + z'**2)

