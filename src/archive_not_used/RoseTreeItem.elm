module RoseTreeItem exposing (..)

import Html exposing(..)

-- START mapping to item
import Dice

import Html.Attributes exposing (..)
import Html.Events exposing (..)
import ParseInt exposing (..)

--type alias ItemModel = Dice.Model
type alias ItemModel = {x:Int, y:Int}
--type alias ItemMsg = Dice.Msg
--type alias ItemMsg 
type Msg = X Int | Y Int | Noop
type alias ItemMsg = Msg

itemInit : Int -> (ItemModel, Cmd ItemMsg)
--itemInit = Dice.init
itemInit x = ({ x=1, y=1 }, Cmd.none)

itemUpdate : ItemMsg -> ItemModel -> (ItemModel, Cmd ItemMsg)
--itemUpdate = Dice.update
itemUpdate msg model =
  case msg of
    X x ->
      ({ model | x = x}, Cmd.none )
    Y y ->
      ({ model | y = y}, Cmd.none )
    Noop ->
     ( model , Cmd.none ) 

itemView : ItemModel -> Html ItemMsg
--itemView = Dice.view
itemView model =
  div [] 
    [ input
      [ value (toString model.x)
      , onInput toMsgX--(\x-> X 10)
      , class "svg_input_general"
      ] []
    , input
      [ value (toString model.y)
      , onInput toMsgY --(\y -> Y 10)
      , class "svg_input_general"
      ] []
    ]

--itemSubscriptions : ItemModel -> Sub ItemMsg
--itemSubscriptions = Dice.subscriptions
--itemSubscriptions model = Noop

toMsgX : String -> Msg
toMsgX str =
  let 
    res = parseInt str
  in 
    case res of
      Err _ ->
        X 1
      Ok x ->
        X x

toMsgY : String -> Msg
toMsgY str =
  let 
    res = parseInt str
  in 
    case res of
      Err _ ->
        Y 1
      Ok y ->
        Y y


-- END mapping to item

-- Add Id

type alias Id = Int

type alias Model =
 { item : ItemModel
 , id : Id }

compare: Model -> Model -> Bool
compare a b = a.id == b.id

--type alias Msg = ItemMsg

init : Id -> Model
init x =
  let (item, msg ) = itemInit 1
  in { item = item
     , id = x }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  let (item, msgItem) = itemUpdate msg model.item
  in
  ({ model | item = item}, msgItem)

view : Model -> Html Msg
view model =
  div [] [ --text (toString model.id)
           --,
           itemView model.item]

--subscriptions : Model -> Sub Msg
--subscriptions model = itemSubscriptions model.item
