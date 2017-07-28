module Attendees.View exposing (root)

import Html
    exposing
        ( Html
        , div
        , input
        , text
        , h2
        , h3
        , h4
        , ul
        , li
        , img
        , textarea
        , span
        )
import Html.Attributes exposing (class, classList, placeholder, src)
import Html.Events exposing (onInput)
import Main.Types exposing (Attendee, Question(..))
import Main.Messages exposing (Msg(..))


root : List Attendee -> Html Msg
root attendees =
    div [ class "attendees" ]
        [ header
        , renderAttendees attendees
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
        ul
            [ class "attendees__list" ]
        <|
            List.map renderAttendee attendees


renderAttendee : Attendee -> Html Msg
renderAttendee attendee =
    li
        [ classList
            [ ( "attendees__attendee-wrapper", True )
            , ( "media", True )
            ]
        ]
        [ div
            [ classList
                [ ( "media", True )
                , ( "media__figure", True )
                , ( "attendees__attendee-info", True )
                ]
            ]
            [ img
                [ classList
                    [ ( "attendees__avatar", True )
                    , ( "media__figure", True )
                    ]
                , src attendee.person.avatarUrl
                ]
                []
            , div [ class "media__body" ]
                [ h3 [ class "attendees__name" ] [ text attendee.person.name ]
                , gitHubUsername attendee.person.gitHubUsername
                ]
            ]
        , div
            [ classList
                [ ( "media__body", True )
                , ( "attendees__questions", True )
                ]
            ]
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
            [ classList
                [ ( element, True )
                , ( modifier, True )
                ]
            ]
            [ h4
                [ class "attendees__question-title" ]
                [ text title ]
            , textarea
                [ class "attendees__question-input"
                , onInput <| UpdateQuestion question attendee.person.id
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
