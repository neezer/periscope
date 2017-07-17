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
import Main.Types exposing (Attendee, Question(..), Msg(..))
import Bem
import Bem.Types
import Bem.Common


block : Bem.Types.Block
block =
    Bem.makeBlock
        "attendees"


makeElement : String -> Bem.Types.Element
makeElement =
    Bem.makeElement block


root : List Attendee -> Html Msg
root attendees =
    div [ class block ]
        [ header
        , renderAttendees attendees
        ]


header : Html Msg
header =
    div [ class <| makeElement "header" ]
        [ h2 [ class <| makeElement "title" ] [ text "Attendees" ]
        , input
            [ class <| makeElement "add-attendee-input"
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
            [ class <| makeElement "list" ]
        <|
            List.map renderAttendee attendees


renderAttendee : Attendee -> Html Msg
renderAttendee attendee =
    li
        [ classList
            [ ( makeElement "attendee-wrapper", True )
            , ( Bem.Common.media, True )
            ]
        ]
        [ div
            [ classList
                [ ( Bem.Common.media, True )
                , ( Bem.Common.mediaFigure, True )
                , ( makeElement "attendee-info", True )
                ]
            ]
            [ img
                [ classList
                    [ ( makeElement "avatar", True )
                    , ( Bem.Common.mediaFigure, True )
                    ]
                , src attendee.person.avatarUrl
                ]
                []
            , div [ class Bem.Common.mediaBody ]
                [ h3 [ class <| makeElement "name" ] [ text attendee.person.name ]
                , gitHubUsername attendee.person.gitHubUsername
                ]
            ]
        , div
            [ classList
                [ ( Bem.Common.mediaBody, True )
                , ( makeElement "questions", True )
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
        [ class <| makeElement "github-username" ]
        [ text <| "@" ++ username ]


questionAnswer : Question -> Attendee -> Html Msg
questionAnswer question attendee =
    let
        element =
            makeElement "question-answer"

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
                [ class <| makeElement "question-title" ]
                [ text title ]
            , textarea
                [ class <| makeElement "question-input"
                , onInput <| UpdateQuestion question attendee.person.id
                ]
                []
            ]


getQuestionDetails : Bem.Types.Element -> Question -> ( Bem.Types.Modifier, String )
getQuestionDetails element question =
    case question of
        WhatDidIDoYesterday ->
            ( Bem.makeModifier element "did-yesterday"
            , "What did I do yesterday?"
            )

        WhatWillIDoToday ->
            ( Bem.makeModifier element "will-do-today"
            , "What will I do today?"
            )

        WhatIsBlockingMe ->
            ( Bem.makeModifier element "blocking-me"
            , "What is blocking me?"
            )

        CanIConnectWith ->
            ( Bem.makeModifier element "connect-with"
            , "Who do I want to connect with?"
            )
