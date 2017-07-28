module Header.View exposing (root)

import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class)
import Main.Messages exposing (Msg)
import Date exposing (Date)
import Date.Extra


root : Maybe Date -> Html Msg
root date =
    div [ class "header" ]
        [ h1 [ class "header__title" ]
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
