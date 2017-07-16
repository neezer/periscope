module Main.View exposing (root)

import Main.Types exposing (Model, Msg)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import YouTubePlayer.View
import Announcements.View
import Attendees.View
import Header.View
import Bem
import Bem.Types


block : Bem.Types.Block
block =
    Bem.makeBlock "wrapper"


root : Model -> Html Msg
root model =
    div [ class block ]
        [ Header.View.root model.date
        , YouTubePlayer.View.root model.inspirationalVideo
        , Announcements.View.root model.announcements
        , Attendees.View.root model.attendees
        ]
