module SvgElement exposing(Model, Msg, init, update, view, create)

-- core
import Html exposing (Html, input, div)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
-- packages
import ParseInt exposing (..)

-- to start just x and y coordinates
type alias Model = 
    { x : Int
    , y : Int }


--type alias ItemMsg 
type Msg 
  = X Int 
  | Y Int 
  | Noop


create : Int -> Int -> Model
create x y = { x = x, y = y }

init : Int -> Int -> (Model, Cmd Msg)
init x y = (create x y, Cmd.none)

view : Model -> Html Msg
view model =
  div [] 
    [ input
      [ value (String.fromInt model.x)
      , onInput (toMsg X) 
      , class "svg_input_general"
      ] []
    , input
      [ value (String.fromInt model.y)
      , onInput (toMsg Y) 
      , class "svg_input_general"
      ] []
    ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    X x ->
      ({ model | x = x}, Cmd.none )
    Y y ->
      ({ model | y = y}, Cmd.none )
    Noop ->
     ( model , Cmd.none ) 

toMsg preMsg str =
  let 
    res = parseInt str
  in 
    case res of
      Err _ ->
        Noop
      Ok int ->
        preMsg int