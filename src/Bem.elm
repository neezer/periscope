module Bem exposing (makeBlock, makeElement, makeModifier)

import Bem.Types


makeBlock : String -> Bem.Types.Block
makeBlock =
    identity


makeElement : Bem.Types.Block -> String -> Bem.Types.Element
makeElement block element =
    block ++ "__" ++ element


makeModifier : Bem.Types.Element -> String -> Bem.Types.Modifier
makeModifier element modifier =
    element ++ "--" ++ modifier
