module Main.View exposing (root)

import Main.Types exposing (Model)
import Main.Messages exposing (Msg(VideoMsg))
import Html exposing (Html, div, button, text)
import Html.Attributes exposing (class)
import Video.View
import Announcements.View
import Attendees.View
import Header.View
import Bem
import Bem.Types


block : Bem.Types.Block
block =
    Bem.makeBlock "wrapper"


endStandupBlock : Bem.Types.Block
endStandupBlock =
    Bem.makeBlock "end-stand-up"


root : Model -> Html Msg
root model =
    div [ class block ]
        [ Header.View.root model.date
        , Html.map VideoMsg <| Video.View.root model.inspirationalVideo
        , Announcements.View.root model.announcements
        , Attendees.View.root model.attendees
        , div [ class endStandupBlock ]
            [ button
                [ class <| Bem.makeElement endStandupBlock "button" ]
                [ text "Conclude Stand-up!" ]
            ]
        ]
