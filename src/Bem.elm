module Bem exposing (makeBlock, makeElement)

import Bem.Types


makeBlock : String -> Bem.Types.Block
makeBlock =
    identity


makeElement : Bem.Types.Block -> String -> Bem.Types.Element
makeElement block element =
    block ++ "__" ++ element
