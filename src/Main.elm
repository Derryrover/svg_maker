module Main exposing (..)

-- core
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Browser exposing(element)

-- self made modules
import ElmStyle

import IdWrapper
import SvgElement
import SvgTreeBuilder
import SvgDisplay
import IdRoseTreeDisplay
import IdRoseTreeUpdate

type alias Model = 
  { svgRoseTree : SvgTreeBuilder.Model }

type Msg 
  = IdRoseTreeDisplayMsg (IdRoseTreeDisplay.Msg SvgElement.Msg SvgElement.Model )

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
    ( { svgRoseTree = SvgTreeBuilder.result
      }
    --, Cmd.batch [Cmd.map SvgElementMsg svgElementMsg]
    , Cmd.batch []
    )

view : Model -> Html Msg
view model = 
  div 
    (ElmStyle.createStyleList [("height", "100vh"), ("width", "100%")] ) 
    [ div -- tree view
        (ElmStyle.createStyleList 
          [ ("float" , "left")
          , ("display", "inline-block")
          , ("height", "100vh")
          , ("margin-right", "3px")] )
        [ Html.map IdRoseTreeDisplayMsg (IdRoseTreeDisplay.view (SvgElement.view) 1 model.svgRoseTree) ]
    , div --svg view
      (ElmStyle.createStyleList [("float" , "left")]) 
      [SvgDisplay.view model.svgRoseTree]
    -- , div -- view of single svg element just to show how message passing with Cmd.batch can be done in code (see init). 
    --   -- This can be removed but then also remove message and model parts
    --     []
    --     [ Html.map SvgElementMsg (SvgElement.view  model.svgElement) ]
    ]

update : Msg -> Model -> ( Model, Cmd Msg )
update (IdRoseTreeDisplayMsg idRoseTreeDisplayMsg) model = 
  let (res, cmd) = IdRoseTreeUpdate.update SvgElement.update idRoseTreeDisplayMsg model.svgRoseTree
  in ({model | svgRoseTree = res}, Cmd.map IdRoseTreeDisplayMsg cmd)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none