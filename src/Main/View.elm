module Main.View exposing (root)

import Main.Types exposing (Model, Msg(..))
import Html exposing (Html, div, text, h1)
import Date exposing (Date)
import Date.Extra
import YouTubePlayer.View


root : Model -> Html Msg
root model =
    div []
        [ header model.date
        , YouTubePlayer.View.root model.inspirationalVideo
        ]


header : Maybe Date -> Html Msg
header date =
    h1 []
        [ text ("Stand-up for " ++ (getFormattedDate date))
        ]


getFormattedDate : Maybe Date -> String
getFormattedDate date =
    case date of
        Just d ->
            Date.Extra.toFormattedString "EEEE MMMM d, y" d

        Nothing ->
            ""
