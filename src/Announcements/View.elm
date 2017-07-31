module Announcements.View exposing (root)

import Html exposing (Html, h2, text, ul, li, div, button, textarea, span)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick, onInput)
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
        ]


header : AnnouncementsView -> Html Msg
header view =
    div [ class "announcements__header" ]
        [ case view of
            None ->
                div []
                    [ h2 [] [ text "No announcements" ]
                    , button
                        [ class "announcements__button"
                        , onClick (Edit Nothing)
                        ]
                        [ text "add one" ]
                    ]

            _ ->
                h2 [] [ text "Announcements" ]
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


action : Html Msg
action =
    button
        [ class "announcements__button"
        , onClick Finish
        ]
        [ text "done" ]


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
                            , id <| announcementId
                            ]
                            [ text record.text ]
                    else
                        displayAnnouncement

                Nothing ->
                    displayAnnouncement
            ]



-- addButton : Bool -> Html Msg
-- addButton noAnnouncements =
--     let
--         buttonText =
--             if noAnnouncements then
--                 "add one"
--             else
--                 "add another"
--     in
--         button
--             [ class "announcements__button"
--             , onClick Add
--             ]
--             [ text buttonText ]
-- edit : Announcement -> Html Msg
-- edit record =
-- renderAnnouncement : Announcement -> Html Msg
-- renderAnnouncement announcement =
--     li
--         [ class "announcements__announcement-wrapper" ]
--         [ showAnnouncement announcement ]
-- showAnnouncement : Announcement -> Html Msg
-- showAnnouncement announcement =
--     let
--         announcementId =
--             "announcement-" ++ toString announcement.id
--     in
--         if announcement.editing then
--             textarea
--                 [ class "announcements__announcement-input"
--                 , onInput <| Update announcement.id
--                 , onEnter FinishEditing
--                 , id <| announcementId
--                 ]
--                 [ text announcement.text ]
--         else
--             span [ id <| announcementId ]
--                 [ text announcement.text ]
