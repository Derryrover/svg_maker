module IdRoseTreeDisplay exposing (view, Msg(..))

-- self made modules
import IdWrapper
import IdRoseTree
import ElmStyle
-- packages
import Tree
-- core
import Basics exposing (..)
import List exposing(map)
import Maybe exposing(..)
import Html exposing (Html, ul, li, div, span, text, node, button, select, option)
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
    listItemAttributes = 
      if depthCounter == 1 then
        List.concat 
          [ listItemStyleList
          , listItemStyleListEvenOdd depthCounter
          ,  [class (oddEvenClass depthCounter)]
          ]
      else
        List.concat 
          [ listItemStyleList
          , listItemNotRoot
          , listItemStyleListEvenOdd depthCounter
          ,  [class (oddEvenClass depthCounter)]
          ]
    listView = 
      if children == [] then
        span [] []
      else 
        ul listStyleList (List.map (view itemViewFunction (depthCounter+1)) children)
  in
    li 
      listItemAttributes
      --(List.concat [listItemStyleList, listItemStyleListEvenOdd depthCounter,  [class (oddEvenClass depthCounter)]])
      [ div 
          [ class "svg_circle_input_whole_item" ] 
          [ Html.map (Direction rootId) (itemViewFunction rootItem) ]
      --, selectBuilder rootId 
      --, ul listStyleList (List.map (view itemViewFunction (depthCounter+1)) children)
      , listView
      ]

isEven : Int -> Bool
isEven int = modBy 2 int == 0

oddEvenClass : Int -> String
oddEvenClass int = 
  if isEven int then
    "class_even"
  else 
    "class_odd"



listItemStyleList = ElmStyle.createStyleList 
  [ ("list-style-type", "none") -- no bullets
  , ("padding", "3px")
  , ("margin", "0px")
  -- , ("margin", "3px")
  -- , ("margin-bottom", "0px")
  -- , ("border-style", "solid")
  -- , ("border-width", "3px")
  -- , ("border-color", "white")
  --, ("-webkit-margin-before", "0px") -- space above first bullet ? not working ?
  --, ("-webkit-margin-after", "0px") -- space below lst bullet ? not working ?
  ]

listItemNotRoot = ElmStyle.createStyleList 
  [ ("list-style-type", "none")
  , ("border-style", "solid")
  , ("border-width", "3px")
  , ("border-color", "white")
  , ("margin", "3px")
  , ("margin-bottom", "0px")
  ]

listItemStyleListEvenOdd int = 
  let 
    color = 
      if (isEven int) then 
        --"blue"
        "#bad4da"
      else
        --"green"
        "#bad4ba"
  in 
    ElmStyle.createStyleList
      [ ("background-color", color)
      ]

listStyleList = ElmStyle.createStyleList 
  [ ("margin-top", "0px") -- space above first bullet
  , ("margin-bottom", "0px") -- space below lst bullet
  , ("padding-left", "28px") -- indentation of each layer of new list
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
