module Header.View exposing (root)

import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class)
import Main.Types exposing (Msg)
import Date exposing (Date)
import Date.Extra
import Bem
import Bem.Types


block : Bem.Types.Block
block =
    Bem.makeBlock "header"


makeElement : String -> Bem.Types.Element
makeElement =
    Bem.makeElement block


root : Maybe Date -> Html Msg
root date =
    div [ class block ]
        [ h1 [ class <| makeElement "title" ]
            [ text ("Stand-up for " ++ (getFormattedDate date))
            ]
        ]


getFormattedDate : Maybe Date -> String
getFormattedDate date =
    case date of
        Just d ->
            Date.Extra.toFormattedString "EEEE MMMM d, y" d

        Nothing ->
            ""
