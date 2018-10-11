module IdWrapper exposing (IdWrapper(..), Id, map)

type IdWrapper a = Wrapper Id a

type alias Id = Int

map: (a -> b) -> IdWrapper a -> IdWrapper b
map f (Wrapper id item) = Wrapper id (f item)

