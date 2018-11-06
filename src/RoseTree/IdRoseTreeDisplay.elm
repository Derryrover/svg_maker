module IdRoseTreeDisplay exposing (view, Msg(..))

-- self made modules
--import IdRoseTreeDisplayCssBox exposing
import IdRoseTreeDisplayCss exposing 
  ( oddEvenClass
  , hrLineStyleList
  , listItemStyleList
  , listItemDivStyleList
  , listItemRoot
  , listItemNotRoot
  , listItemStyleListEvenOdd
  , listStyleList 
  )
import IdWrapper
import IdRoseTree
import ElmStyle
-- packages
import Tree
-- core
import Basics exposing (..)
import List exposing(map)
import Maybe exposing(..)
import Html exposing (Html, ul, li, div, span, hr, text, node, button, select, option)
import Html.Attributes exposing (..)
import Html.Events exposing(onInput)

type Msg aMsg aModel 
  = Direction IdWrapper.Id aMsg 
  | New IdWrapper.Id --id parent
  | CreatedRandom IdWrapper.Id IdWrapper.Id -- id-parent new-id

view : ( aModel -> Html aMsg) -> Int -> IdRoseTree.Model aModel -> Html (Msg aMsg aModel)
view itemViewFunction depthCounter treeModel = 
  let
    rootWithId = Tree.label treeModel
    rootId = IdWrapper.getId rootWithId
    rootItem = IdWrapper.getItem rootWithId
    children = Tree.children treeModel
    listItemAttributesGeneral = List.concat 
      [ listItemStyleList
      , listItemStyleListEvenOdd depthCounter 
      , [class (oddEvenClass depthCounter)]
      ]
    listItemAttributes = 
      if depthCounter == 1 then
        List.concat 
          [ listItemAttributesGeneral
          , listItemRoot
          ]
      else
        List.concat 
          [ listItemAttributesGeneral
          , listItemNotRoot
          ]
    listView = 
      if children == [] then
        span [] []
      else 
        ul listStyleList (List.map (view itemViewFunction (depthCounter+1)) children)
  in
    li 
      listItemAttributes
      [ hr (hrLineStyleList depthCounter) [] 
      , div 
          ( List.concat
            [ listItemDivStyleList 
            , [ class "svg_circle_input_whole_item" ] 
            ]
          )
          [ Html.map (Direction rootId) (itemViewFunction rootItem) 
          , listView ]
      --, selectBuilder rootId 
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
