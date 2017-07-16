module Bem.Common exposing (..)

import Bem
import Bem.Types


media : Bem.Types.Block
media =
    Bem.makeBlock "media"


mediaFigure : Bem.Types.Element
mediaFigure =
    Bem.makeElement media "figure"


mediaBody : Bem.Types.Element
mediaBody =
    Bem.makeElement media "body"
