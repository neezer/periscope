module Announcements.View exposing (root)

import Html exposing (Html, h2, text, ul, li, div, button, textarea, span)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick, onInput)
import Bem
import Bem.Types
import Main.Types exposing (Announcement, Msg(..))
import Extra exposing (onEnter)


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
        , noAnnouncements announcements
        ]


noAnnouncements : List Announcement -> Html Msg
noAnnouncements announcements =
    if List.isEmpty announcements then
        div [ class <| makeElement "make-new-wrapper" ]
            [ h2
                [ class <| makeElement "make-new-title" ]
                [ text "No announcements" ]
            , addButton
            ]
    else
        text ""


addButton : Html Msg
addButton =
    button
        [ class <| makeElement "button"
        , onClick AddAnnouncement
        ]
        [ text "add announcement" ]


renderAnnouncements : List Announcement -> Html Msg
renderAnnouncements announcements =
    let
        isEditing =
            announcements
                |> List.filter (\a -> a.editing)
                |> List.isEmpty
                |> not

        nextButton =
            if isEditing then
                doneButton
            else
                addButton
    in
        if List.isEmpty announcements then
            text ""
        else
            div []
                [ ul
                    [ class <| makeElement "announcement-list" ]
                  <|
                    List.map renderAnnouncement announcements
                , nextButton
                ]


doneButton : Html Msg
doneButton =
    button
        [ class <| makeElement "button"
        , onClick FinishEditingAnnouncement
        ]
        [ text "done editing" ]


renderAnnouncement : Announcement -> Html Msg
renderAnnouncement announcement =
    li
        [ class <| makeElement "announcement-wrapper" ]
        [ showAnnouncement announcement ]


showAnnouncement : Announcement -> Html Msg
showAnnouncement announcement =
    let
        announcementId =
            "announcement-" ++ toString announcement.id
    in
        if announcement.editing then
            textarea
                [ class <| makeElement "announcement-input"
                , onInput <| UpdateAnnouncement announcement.id
                , onEnter FinishEditingAnnouncement
                , id <| announcementId
                ]
                [ text announcement.text ]
        else
            span [ id <| announcementId ]
                [ text announcement.text ]
