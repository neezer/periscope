module Announcements.View exposing (root)

import Html exposing (Html, h2, text, ul, li, div, button, textarea, span)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick, onInput)
import Announcements.Model exposing (Model, Announcement)
import Announcements.Messages exposing (Msg(..))
import Extra exposing (onEnter)


root : Model -> Html Msg
root model =
    div [ class "announcements" ]
        [ header model.records
        , renderAnnouncements model.records
        ]


header : List Announcement -> Html Msg
header announcements =
    if List.isEmpty announcements then
        div [ class "announcements__make-new-wrapper" ]
            [ h2
                [ class "announcements__make-new-title" ]
                [ text "No announcements" ]
            , addButton <| List.isEmpty announcements
            ]
    else
        h2
            [ class "announcements__header" ]
            [ text "Announcements" ]


addButton : Bool -> Html Msg
addButton noAnnouncements =
    let
        buttonText =
            if noAnnouncements then
                "add one"
            else
                "add another"
    in
        button
            [ class "announcements__button"
            , onClick Add
            ]
            [ text buttonText ]


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
                addButton <| List.isEmpty announcements
    in
        if List.isEmpty announcements then
            text ""
        else
            div []
                [ ul
                    [ class "announcements__announcement-list" ]
                  <|
                    List.map renderAnnouncement announcements
                , nextButton
                ]


doneButton : Html Msg
doneButton =
    button
        [ class "announcements__button"
        , onClick FinishEditing
        ]
        [ text "done" ]


renderAnnouncement : Announcement -> Html Msg
renderAnnouncement announcement =
    li
        [ class "announcements__announcement-wrapper" ]
        [ showAnnouncement announcement ]


showAnnouncement : Announcement -> Html Msg
showAnnouncement announcement =
    let
        announcementId =
            "announcement-" ++ toString announcement.id
    in
        if announcement.editing then
            textarea
                [ class "announcements__announcement-input"
                , onInput <| Update announcement.id
                , onEnter FinishEditing
                , id <| announcementId
                ]
                [ text announcement.text ]
        else
            span [ id <| announcementId ]
                [ text announcement.text ]
