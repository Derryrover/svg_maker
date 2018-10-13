module IdRoseTreeDisplay exposing (view, Msg(..))

-- self made modules
import IdWrapper
import IdRoseTree

-- core
import Tree
import List exposing(map)
import Maybe exposing(..)
import Html exposing (Html, ul, li, div, text, node, button, select, option)
import Html.Attributes exposing (..)
import Html.Events exposing(onInput)

type Msg aMsg aModel 
  = Direction IdWrapper.Id aMsg 
  | New IdWrapper.Id --id parent
  | CreatedRandom IdWrapper.Id IdWrapper.Id -- id-parent new-id

init tree = {tree=tree, idHideSelect = Nothing}

view : ( aModel -> Html aMsg) -> IdRoseTree.Model aModel -> Html (Msg aMsg aModel)
view itemViewFunction treeModel = 
  let
    rootWithId = Tree.label treeModel
    rootId = IdWrapper.getId rootWithId
    rootItem = IdWrapper.getItem rootWithId
    children = Tree.children treeModel
  in
    li 
      []
      [ div 
          [ class "svg_circle_input_whole_item" ] 
          [ Html.map (Direction rootId) (itemViewFunction rootItem) ]
      --, selectBuilder rootId 
      , ul [] (List.map (view itemViewFunction) children)
      ]


-- selectItems = [ "circle", "rect", "ellipse", "line", "polyline", "polygon", "path"]

-- selectBuilder rootId = 
--   select 
--     [ class "svg_input_general div_new_tree_child_select"
--     , onInput (\n->(New rootId))
--     , id (String.fromInt rootId)
--     ] 
--     (List.concat 
--       [
--         [ option [(value "select new item"), selected True, disabled True, hidden True] [text "select new item"]]
--         , List.map (\item-> option [(value item)] [text item]) selectItems 
--       ])
