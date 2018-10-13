module IdRoseTree exposing (Model)

--import RoseTree exposing (..)
import Tree exposing (Tree)
import IdWrapper exposing (..)

--type alias Model a = RoseTree (IdWrapper a)
type alias Model a = Tree (IdWrapper a)
