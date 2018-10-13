module SvgTreeBuilder exposing (Model, IdWrappedSvgElement, result)

-- packages
import Tree exposing (Tree, tree)

-- self made
import IdWrapper exposing (IdWrapper(..), Id, map)
import SvgElement exposing(create)
import IdRoseTree

type alias Model = IdRoseTree.Model SvgElement.Model

type alias IdWrappedSvgElement = IdWrapper SvgElement.Model

createDummie : SvgElement.Model
createDummie = create 1 1


fromId: Id -> IdWrappedSvgElement
fromId id = Wrapper id createDummie

result : Model
result = 
    Tree.tree (fromId 1)
         [ Tree.tree (fromId 11) []
         , Tree.tree (fromId 12) []
         , Tree.tree (fromId 13) []
         , Tree.tree (fromId 14) []
         , Tree.tree (fromId 15) 
            [ Tree.tree (fromId 151) []
            ]
         , Tree.tree (fromId 15) []
         ]