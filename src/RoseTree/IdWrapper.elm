module IdWrapper exposing (..)

type Wrapper a = Wrapper Id a

type alias Id = Int

map: (a -> b) -> Wrapper a -> Wrapper b
map f (Wrapper id item) = Wrapper id (f item)

