module BinTree
    ( Tree (..)
    , BinaryTree (..)
    , TwoThreeTree (..)
    ) where

class Tree t where
  treeInsert :: Ord d => t d -> d -> t d
  treeBuild  :: Ord d => t d -> [d] -> t d
  treeBuild tree values = foldl treeInsert tree values

data BinaryTree d = BinaryEmpty
                  | BinaryNode (BinaryTree d) d (BinaryTree d)
                  deriving (Show)

instance Tree BinaryTree where
  --treeInsert :: Ord d => BinaryTree d -> d -> BinaryTree d
  treeInsert BinaryEmpty v = BinaryNode BinaryEmpty v BinaryEmpty
  treeInsert node@(BinaryNode left n right) v
    | v == n    = node
    | v < n     = BinaryNode (treeInsert left v) n right
    | otherwise = BinaryNode left n (treeInsert right v)
  -- treeBuild :: Ord d => BinaryTree d -> [d] -> BinaryTree d
  -- treeBuild tree values = foldl treeInsert tree values

{--}
data TwoThreeTree d = TwoThreeEmpty
                    | RootNode (TwoThreeTree d)
                    | TwoNode (TwoThreeTree d) d (TwoThreeTree d)
                    | ThreeNode (TwoThreeTree d) d (TwoThreeTree d) d (TwoThreeTree d)
                    | FourNode  (TwoThreeTree d) d (TwoThreeTree d) d (TwoThreeTree d) d (TwoThreeTree d)
                    deriving (Show, Eq)

twoLeaf :: d -> TwoThreeTree d
twoLeaf v = TwoNode TwoThreeEmpty v TwoThreeEmpty

threeLeaf :: d -> d -> TwoThreeTree d
threeLeaf v1 v2 = ThreeNode TwoThreeEmpty v1 TwoThreeEmpty v2 TwoThreeEmpty

fourLeaf :: d -> d -> d -> TwoThreeTree d
fourLeaf v1 v2 v3 = FourNode TwoThreeEmpty v1 TwoThreeEmpty v2 TwoThreeEmpty v3 TwoThreeEmpty

isLeaf :: Eq d => TwoThreeTree d -> Bool
isLeaf (TwoNode first n second) =
  first == TwoThreeEmpty || second == TwoThreeEmpty
isLeaf (ThreeNode first n1 second n2 third) =
  first == TwoThreeEmpty || second == TwoThreeEmpty || third == TwoThreeEmpty

instance Tree TwoThreeTree where
  treeInsert TwoThreeEmpty v = TwoNode TwoThreeEmpty v TwoThreeEmpty

  treeInsert node@(TwoNode first n second) v
    | v < n     =
        if isLeaf node then threeLeaf v n
        else case (treeInsert first v) of
          FourNode c1 a c2 b c3 c c4 -> ThreeNode (TwoNode c1 a c2) b (TwoNode c3 c c4) n second
          nFirst@_                   -> TwoNode nFirst n second
    | v == n    = node
    | otherwise =
        if isLeaf node then threeLeaf n v
        else case (treeInsert second v) of
          FourNode c1 a c2 b c3 c c4 -> ThreeNode first n (TwoNode c1 a c2) b (TwoNode c3 c c4)
          nSecond@_                  -> TwoNode first n nSecond

  treeInsert node@(ThreeNode first n1 second n2 third) v
    | v < n1    =
        if isLeaf node then fourLeaf v n1 n2
        else case (treeInsert first v) of
          FourNode c1 a c2 b c3 c c4 -> FourNode (TwoNode c1 a c2) b (TwoNode c3 c c4) n1 second n2 third
          nFirst@_                   -> ThreeNode nFirst n1 second n2 third
    | v == n1   = node
    | v < n2    =
        if isLeaf node then fourLeaf n1 v n2
        else case (treeInsert second v) of
          FourNode c1 a c2 b c3 c c4 -> FourNode first n1 (TwoNode c1 a c2) b (TwoNode c3 c c4) n2 third
          nSecond@_                  -> ThreeNode first n1 nSecond n2 third
    | v == n2   = node
    | otherwise =
        if isLeaf node then fourLeaf n1 n2 v
        else case (treeInsert third v) of
          FourNode c1 a c2 b c3 c c4 -> FourNode first n1 second n2 (TwoNode c1 a c2) b (TwoNode c3 c c4)
          nThird@_                   -> ThreeNode first n1 second n2 nThird

  treeInsert (RootNode first) v =
    case (treeInsert first v) of
        FourNode c1 a c2 b c3 c c4 -> RootNode (TwoNode (TwoNode c1 a c2) b (TwoNode c3 c c4))
        nFirst@_                   -> RootNode nFirst

{--}
