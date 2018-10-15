module SvgElementCss exposing (..)

-- self made
import ElmStyle
import IdRoseTreeDisplayCssConstants exposing (listIndent)

-- set this  margin rest should be calculated
marginBetweenInputLabel = 3
-- set it to be equal to indentation of list
inputWidth = listIndent 
labelWidth = inputWidth - marginBetweenInputLabel




inputStyleList = ElmStyle.createStyleList 
  [ ("box-sizing", "border-box")
  , ("border-radius", "0px")
  , ("background-color", "white") 
  , ("border-style", "none")
  , ("margin", "1px")
  , ("margin-left", "0px")
  --, ("width", "40px")
  , ("width", ElmStyle.intToPxString inputWidth)
  ]

labelStyleList = ElmStyle.createStyleList 
  [ ("width", ElmStyle.intToPxString labelWidth)
  , ("display", "block")
  , ("text-align", "right")
  , ("clear", "both")
  , ("float", "left")
  , ("margin-right", ElmStyle.intToPxString marginBetweenInputLabel)
  ]