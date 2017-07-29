module Attendees.View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (class, placeholder, src)
import Html.Events exposing (onInput)
import Attendees.Model exposing (Model, Attendee)
import Attendees.Messages exposing (Msg(..), Question(..))


root : Model -> Html Msg
root model =
    div [ class "attendees" ]
        [ header
        , renderAttendees model.records
        ]


header : Html Msg
header =
    div [ class "attendees__header" ]
        [ h2 [ class "attendees__title" ] [ text "Attendees" ]
        , input
            [ class "attendees__add-attendee-input"
            , placeholder "Add attendee"
            ]
            []
        ]


renderAttendees : List Attendee -> Html Msg
renderAttendees attendees =
    if List.isEmpty attendees then
        text ""
    else
        ul [ class "attendees__list" ] <| List.map renderAttendee attendees


renderAttendee : Attendee -> Html Msg
renderAttendee attendee =
    li
        [ class "attendees__attendee-wrapper media" ]
        [ div
            [ class "attendees__attendee-info media media__figure" ]
            [ img
                [ class "attendees__avatar media__figure"
                , src attendee.person.avatarUrl
                ]
                []
            , div [ class "media__body" ]
                [ h3 [ class "attendees__name" ] [ text attendee.person.name ]
                , gitHubUsername attendee.person.gitHubUsername
                ]
            ]
        , div
            [ class "attendees__questions media__body" ]
            [ questionAnswer WhatDidIDoYesterday attendee
            , questionAnswer WhatWillIDoToday attendee
            , questionAnswer WhatIsBlockingMe attendee
            , questionAnswer CanIConnectWith attendee
            ]
        ]


gitHubUsername : String -> Html Msg
gitHubUsername username =
    span
        [ class "attendees__github-username" ]
        [ text <| "@" ++ username ]


questionAnswer : Question -> Attendee -> Html Msg
questionAnswer question attendee =
    let
        element =
            "attendees__question-answer"

        ( modifier, title ) =
            getQuestionDetails element question
    in
        div
            [ class <| element ++ " " ++ modifier ]
            [ h4
                [ class "attendees__question-title" ]
                [ text title ]
            , textarea
                [ class "attendees__question-input"
                , onInput <| Update attendee.person.id question
                ]
                []
            ]


getQuestionDetails : String -> Question -> ( String, String )
getQuestionDetails element question =
    case question of
        WhatDidIDoYesterday ->
            ( element ++ "--did-yesterday"
            , "What did I do yesterday?"
            )

        WhatWillIDoToday ->
            ( element ++ "--will-do-today"
            , "What will I do today?"
            )

        WhatIsBlockingMe ->
            ( element ++ "--blocking-me"
            , "What is blocking me?"
            )

        CanIConnectWith ->
            ( element ++ "--connect-with"
            , "Who do I want to connect with?"
            )
