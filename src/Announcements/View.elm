module Announcements.View exposing (root)

import Html exposing (Html, h2, text, ul, li, div, button, textarea, span)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick, onInput, onBlur)
import Announcements.Model
    exposing
        ( Model
        , Announcement
        , AnnouncementsView(..)
        )
import Announcements.Messages exposing (Msg(..))
import Extra exposing (onEnter)


root : Model -> Html Msg
root { view, records } =
    div [ class "announcements" ]
        [ header view
        , render view records
        , action view
        ]


header : AnnouncementsView -> Html Msg
header view =
    h2 [ class "announcements__header" ]
        [ case view of
            None ->
                text "No announcements"

            _ ->
                text "Announcements"
        ]


render : AnnouncementsView -> List Announcement -> Html Msg
render av records =
    case av of
        None ->
            text ""

        Editing focusedRecord ->
            list (show <| Just focusedRecord) records

        List ->
            list (show Nothing) records


list : (Announcement -> Html Msg) -> List Announcement -> Html Msg
list renderer records =
    div []
        [ ul
            [ class "announcements__announcement-list" ]
          <|
            List.map renderer records
        ]


action : AnnouncementsView -> Html Msg
action view =
    let
        makeButton handler label =
            button [ class "announcements__button", onClick handler ]
                [ text label ]
    in
        case view of
            None ->
                makeButton (Edit Nothing) "add one"

            Editing _ ->
                makeButton Finish "done"

            _ ->
                makeButton (Edit Nothing) "add another"


show : Maybe Announcement -> Announcement -> Html Msg
show focusedRecord record =
    let
        announcementId =
            "announcement-" ++ toString record.id

        displayAnnouncement =
            span
                [ id <| announcementId ]
                [ text record.text ]
    in
        li
            [ class "announcements__announcement-wrapper"
            , onClick (Edit <| Just record.id)
            ]
            [ case focusedRecord of
                Just fr ->
                    if fr.id == record.id then
                        textarea
                            [ class "announcements__announcement-input"
                            , onInput <| Update record.id
                            , onEnter Finish
                            , onBlur Finish
                            , id <| announcementId
                            ]
                            [ text record.text ]
                    else
                        displayAnnouncement

                Nothing ->
                    displayAnnouncement
            ]
