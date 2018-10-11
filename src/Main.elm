module Main exposing (..)

-- core
import Html exposing (Html, div, text)
import Browser exposing(element)

-- self made modules
import RoseTree
import IdWrapper
import SvgElement

type alias Model = 
  { svgElement : SvgElement.Model}

type Msg 
  = SvgElementMsg SvgElement.Msg 
  | Noop

-- main = 
--   div [] 
--     [ text "Hello World" ]

main = Browser.element
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

init : () -> (Model, Cmd Msg)
init _ =
  let
    (svgElementModel , svgElementMsg) = SvgElement.init 1 1
  in
    ({ svgElement = svgElementModel }, Cmd.batch [Cmd.map SvgElementMsg svgElementMsg])

view : Model -> Html Msg
view model =
  div [] 
    [ text "Hello World"
    , Html.map SvgElementMsg (SvgElement.view  model.svgElement) ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
  case msg of
    SvgElementMsg svgElementMsgIn ->
      let
        (svgElementModel , svgElementMsgOut) = SvgElement.update svgElementMsgIn model.svgElement
      in
        ({ model | svgElement = svgElementModel }, Cmd.map SvgElementMsg svgElementMsgOut)
    Noop ->
      (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none