module Main.View exposing (root)

import Main.Types exposing (Model)
import Main.Messages exposing (Msg(VideoMsg, AnnouncementsMsg))
import Html exposing (Html, div, button, text)
import Html.Attributes exposing (class)
import Video.View
import Announcements.View
import Attendees.View
import Header.View


root : Model -> Html Msg
root model =
    div [ class "wrapper" ]
        [ Header.View.root model.date
        , Html.map VideoMsg <| Video.View.root model.inspirationalVideo
        , Html.map AnnouncementsMsg <| Announcements.View.root model.announcements
        , Attendees.View.root model.attendees
        , div [ class "end-stand-up" ]
            [ button
                [ class "end-stand-up__button" ]
                [ text "Conclude Stand-up!" ]
            ]
        ]
