module Announcements.View exposing (root)

import Html exposing (Html, h1, text, ul, li, div, button, textarea)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Bem
import Bem.Types
import Main.Types exposing (Announcement, Msg(..))


block : Bem.Types.Block
block =
    Bem.makeBlock "announcements"


makeElement : String -> Bem.Types.Element
makeElement =
    Bem.makeElement block


root : List Announcement -> Html Msg
root announcements =
    div [ class block ]
        [ renderAnnouncements announcements
        , div [ class <| makeElement "make-new" ]
            [ button
                [ onClick AddAnnouncement ]
                [ text "Add Announcement..." ]
            ]
        ]


renderAnnouncements : List Announcement -> Html Msg
renderAnnouncements announcements =
    if List.isEmpty announcements then
        text ""
    else
        ul
            [ class <| makeElement "announcement-list" ]
        <|
            List.map renderAnnouncement announcements


renderAnnouncement : Announcement -> Html Msg
renderAnnouncement announcement =
    li
        [ class <| makeElement "announcement-wrapper" ]
        [ showAnnouncement announcement ]


showAnnouncement : Announcement -> Html Msg
showAnnouncement announcement =
    if announcement.editing then
        textarea [] [ text announcement.text ]
    else
        text announcement.text
