module SvgTreeBuilder exposing (Model, result, createSvgRoseTree)

import RoseTree exposing (RoseTree, singleton, addChildren)
import IdWrapper exposing (IdWrapper, Id, map)
import SvgElement
import IdRoseTree

--type alias Model = RoseTree (IdWrapper SvgElement.Model)
type alias Model = IdRoseTree.Model SvgElement.Model

createSvgRoseTree : Int -> Int -> Int -> Model
createSvgRoseTree id x y = RoseTree.singleton (IdWrapper.Wrapper id (SvgElement.create x y))

createDummieSvgRoseTree : Int -> Model
createDummieSvgRoseTree id = createSvgRoseTree id 1 1

tree1  = createDummieSvgRoseTree 1
tree11 = createDummieSvgRoseTree 11
tree12 = createDummieSvgRoseTree 12
tree13 = createDummieSvgRoseTree 13
tree14 = createDummieSvgRoseTree 14
tree15 = createDummieSvgRoseTree 15

tree151 = createDummieSvgRoseTree 151

tree15Complete = RoseTree.addChildren [tree151] tree15

result = RoseTree.addChildren [tree11, tree12, tree13, tree14, tree15Complete] tree1
