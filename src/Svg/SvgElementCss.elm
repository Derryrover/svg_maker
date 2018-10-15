module SvgElementCss exposing (..)

import ElmStyle

inputStyleList = ElmStyle.createStyleList 
  [ ("border-radius", "0px")
  , ("background-color", "white") 
  , ("border-style", "none")
  , ("margin", "1px")
  --, ("width", "40px")
  , ("width", "48px")
  ]

labelStyleList = ElmStyle.createStyleList 
  [ ("width", "40px")
  , ("display", "block")
  , ("text-align", "right")
  , ("clear", "both")
  , ("float", "left")
  , ("margin-right", "3px")
  ]