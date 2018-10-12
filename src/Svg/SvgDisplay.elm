module SvgDisplay exposing (view)

import RoseTree exposing(..)
import Html exposing (..)
import Svg exposing (circle, line, svg, g)
import Svg.Attributes exposing (..)
import SvgTreeBuilder
import IdWrapper

view tree = svg [ viewBox "0 0 100 100", width "300px" ] [drawLayer tree]

drawLayer : SvgTreeBuilder.Model -> Html a
drawLayer tree =
  let
    treeItem = (RoseTree.root tree)
    svgItem = IdWrapper.getItem treeItem
    children = RoseTree.children tree
    translateXY = "translate("++ (String.fromInt svgItem.x) ++" "++ (String.fromInt svgItem.y) ++")"
  in
    g
      [transform translateXY]
      ( ( circle [cx "0", cy "0", r "5", fill "#bad4ba"][])
        ::
        (List.map drawLayer children) )

