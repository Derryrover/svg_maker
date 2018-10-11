module RoseTree exposing (RoseTree, singleton, root, children, addChildren, updateRose, map, findAndUpdate)

-- core
import List exposing(map, foldr)

{-| RoseTree type.
A rosetree is a tree with a root whose children are themselves
rosetrees.
-}
type RoseTree a
    = Rose a (List (RoseTree a))


{-| Make a singleton rosetree
-}
singleton : a -> RoseTree a
singleton a =
    Rose a []


{-| Get the root of a rosetree
-}
root : RoseTree a -> a
root (Rose a _) =
    a


{-| Get the children of a rosetree
-}
children : RoseTree a -> List (RoseTree a)
children (Rose _ c) =
    c


{-| Add a child to the rosetree.
-}
addChild : RoseTree a -> RoseTree a -> RoseTree a
addChild child (Rose a c) =
    Rose a (child :: c)


addChildren : List( RoseTree a ) -> RoseTree a -> RoseTree a
addChildren list tree =
 List.foldr addChild tree list


{-| Update Rose
-}
updateRose : a -> RoseTree a -> RoseTree a
updateRose a (Rose _ list) =
  let rose = singleton a
  in addChildren list rose


{-| Map a function over a rosetree
-}
map : (a -> b) -> RoseTree a -> RoseTree b
map f (Rose a c) =
    Rose (f a) (List.map (map f) c)

flatten : RoseTree a -> List a
flatten (Rose a list) =
  let
    parentList = [a]
    childrenLists = List.map flatten list
  in
    List.append parentList (List.concat childrenLists)

{-
updateChildrenRecursive: (RoseTree a -> RoseTree a) -> RoseTree a -> RoseTree a
updateChildrenRecursive f tree =
  let
    childs = children tree
    updatedChildren = List.map (updateChildrenRecursive f ) childs
  in
    addChildren updatedChildren tree
-}

updateChildrenFlat: (RoseTree a -> RoseTree a) -> RoseTree a -> RoseTree a
updateChildrenFlat f tree =
  let
    rootTree = singleton (root tree)
    childs = children tree
    updatedChildren = List.map f childs
  in
    addChildren updatedChildren rootTree

-- find and update item(s) in rosetree
-- find item(s) in a RoseTree by passing the testFunction: test function should return true for any rosetree to update
-- Those Rosetrees are then updated by applying the funcFunction 
findAndUpdate : (RoseTree a -> Bool) -> ( RoseTree a -> RoseTree a) -> RoseTree a -> RoseTree a
findAndUpdate test func tree =
  if test tree then
    func tree
  else
    updateChildrenFlat (findAndUpdate test func) tree








