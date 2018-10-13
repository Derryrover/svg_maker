module IdRoseTree exposing (Model)

import RoseTree exposing (..)
import IdWrapper exposing (..)

type alias Model a = RoseTree (IdWrapper a)
