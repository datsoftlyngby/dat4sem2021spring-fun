module LastDay where


-- Strings
--   Comprehensions
--   Ranges

names :: [String]
names = ["Anders", "Bente", "Christine", "Dorte", "Erik"]

numbers :: [Integer]
numbers = [2,7..17]

pairs :: [(Integer, String)]
pairs = [(number, name) | number <- numbers, name <- names]

--   Folds
--     Left
--     Right
sumOfNumbers :: [Integer] -> Integer
sumOfNumbers theNumbers = foldl (\acc x -> acc + x) 0 theNumbers

sumOfNumbersUnsecure :: [Integer] -> Integer
sumOfNumbersUnsecure theNumbers = foldl1 (\acc x -> acc + x) theNumbers

reverseNumbers :: [Integer] -> [Integer]
reverseNumbers theNumbers = foldl (\accumulatedNumbers x -> x : accumulatedNumbers) [] theNumbers

doubleNumbers :: [Integer] -> [Integer]
doubleNumbers theNumbers = foldr (\x accumulatedNumbers -> (2*x) : accumulatedNumbers) [] theNumbers

-- Operators as functions and infix functions

(--==) :: Integer -> Integer -> Integer
a --== b = 6*a + b

contains :: (Eq a) => [a] -> a -> Bool
contains [] item = False
contains (head : rest) item = if item == head then True else contains rest item

{-
numbers `contains` 12      True
contains numbers 12        True

5 --== 7                   37
(--==) 5 7                 37
-}

{-

** Functors

class Functor f where
  fmap :: (a -> b) -> f a -> f b

** Applicative

class (Functor f) => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b


  [a -> b] <*> [a] -> [b]
  Just (a -> b) <*> Just a -> Just b

** Monoids

class Semigroup a where
  (<>) :: a -> a -> a

class (Semigroup m) => Monoid m where
  mempty :: m
  mappend :: m -> m -> m
  mappend = (<>)

  mconcat :: [m] -> m
  mconcat = foldr mappend mempty
-}


data Produkt a = Produkt { getProduct :: a } deriving (Eq, Ord, Read, Show, Bounded)

instance (Num a) => Semigroup (Produkt a) where
  (Produkt x) <> (Produkt y) = Produkt (x*y)

instance (Num a) => Monoid (Produkt a) where
  mempty = Produkt 1
  -- mappend (Produkt x) (Produkt y) = Produkt (x*y)

{-
class (Applicative m) => Monad m where
  return :: a -> m a
  (>>=) :: m a -> (a -> m b) -> m b

  (>>)
  fail

-}

type Birds = Int
type Pole = (Birds, Birds)

landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right)
  | abs ((left + n) - right) < 4 = Just (left + n, right)
  | otherwise                    = Nothing

landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right)
  | abs ((left) - right + n) < 4 = Just (left, right + n)
  | otherwise                    = Nothing

(-:) :: a -> (a -> a) -> a
x -: f = f x

-- return (0,0) >>= landLeft 2 >>= landRight 2 >>= landLeft 1

scene :: Maybe Pole
scene = do
  p0 <- return (0, 0)
  p1 <- landLeft 2 p0
  p2 <- landRight 2 p1
  landLeft 1 p2


