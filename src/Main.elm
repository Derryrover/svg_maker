module Main exposing (..)

-- core
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Browser exposing(element)

-- self made modules
import ElmStyle

import RoseTree
import IdWrapper
import SvgElement
import SvgTreeBuilder
import SvgDisplay
import IdRoseTreeDisplay
import IdRoseTreeUpdate

type alias Model = 
  { svgElement : SvgElement.Model
  , svgRoseTree : SvgTreeBuilder.Model }

type Msg 
  = SvgElementMsg SvgElement.Msg 
  | IdRoseTreeDisplayMsg (IdRoseTreeDisplay.Msg SvgElement.Msg SvgElement.Model )
  | Noop

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
    ( { svgElement = svgElementModel 
      , svgRoseTree = SvgTreeBuilder.result
      }
    , Cmd.batch [Cmd.map SvgElementMsg svgElementMsg]
    )

view : Model -> Html Msg
view model = 
  div 
    [] 
    [ div 
        (ElmStyle.createStyleList [("float" , "left"),("display", "inline-block")] )
        --[ Html.map SvgElementMsg (SvgElement.view  model.svgElement) ]
        [ Html.map IdRoseTreeDisplayMsg (IdRoseTreeDisplay.view (SvgElement.view) model.svgRoseTree) ]
    , div (ElmStyle.createStyleList [("float" , "left")]) [SvgDisplay.view model.svgRoseTree]
    --, Html.map IdRoseTreeDisplayMsg (IdRoseTreeDisplay.view (SvgElement.view) model.svgRoseTree)
    ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
  case msg of
    SvgElementMsg svgElementMsgIn ->
      let
        (svgElementModel , svgElementMsgOut) = SvgElement.update svgElementMsgIn model.svgElement
      in
        ({ model | svgElement = svgElementModel }, Cmd.map SvgElementMsg svgElementMsgOut)
    IdRoseTreeDisplayMsg idRoseTreeDisplayMsg ->
      --(model, Cmd.none)
      let (res, cmd) = IdRoseTreeUpdate.update SvgElement.update model.svgRoseTree idRoseTreeDisplayMsg
      in ({model | svgRoseTree = res}, Cmd.map IdRoseTreeDisplayMsg cmd)
    Noop ->
      (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none