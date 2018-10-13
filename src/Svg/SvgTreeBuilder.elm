module SvgTreeBuilder exposing (Model, IdWrappedSvgElement, result)

--import RoseTree exposing (RoseTree, singleton, addChildren)
import Tree exposing (Tree, tree)
import IdWrapper exposing (IdWrapper(..), Id, map)
import SvgElement exposing(create)
import IdRoseTree

--type alias Model = RoseTree (IdWrapper SvgElement.Model)
type alias Model = IdRoseTree.Model SvgElement.Model

type alias IdWrappedSvgElement = IdWrapper SvgElement.Model

-- createSvgRoseTree : Int -> Int -> Int -> Model
-- createSvgRoseTree id x y = RoseTree.singleton (IdWrapper.Wrapper id (SvgElement.create x y))

-- createDummieSvgRoseTree : Int -> Model
-- createDummieSvgRoseTree id = createSvgRoseTree id 1 1

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
-- myTree : Tree Int
-- myTree =
--     Tree.tree 1
--         [ Tree.singleton 2
--         , Tree.singleton 3
--         ]





-- tree1  = createDummieSvgRoseTree 1
-- tree11 = createDummieSvgRoseTree 11
-- tree12 = createDummieSvgRoseTree 12
-- tree13 = createDummieSvgRoseTree 13
-- tree14 = createDummieSvgRoseTree 14
-- tree15 = createDummieSvgRoseTree 15

-- tree151 = createDummieSvgRoseTree 151

-- tree15Complete = RoseTree.addChildren [tree151] tree15

-- result = RoseTree.addChildren [tree11, tree12, tree13, tree14, tree15Complete] tree1
