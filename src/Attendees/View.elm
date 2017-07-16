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
import Main.Types exposing (Person, Msg)
import Bem
import Bem.Types
import Bem.Common
import Attendees.Types exposing (Question(..))


block : Bem.Types.Block
block =
    Bem.makeBlock
        "attendees"


makeElement : String -> Bem.Types.Element
makeElement =
    Bem.makeElement block


root : List Person -> Html Msg
root attendees =
    div [ class block ]
        [ h2 [ class <| makeElement "title" ] [ text "Attendees" ]
        , addAttendee
        , renderAttendees attendees
        ]


addAttendee : Html Msg
addAttendee =
    input [ placeholder "Add attendee" ] []


renderAttendees : List Person -> Html Msg
renderAttendees attendees =
    if List.isEmpty attendees then
        text ""
    else
        ul
            [ class <| makeElement "list" ]
        <|
            List.map renderAttendee attendees


renderAttendee : Person -> Html Msg
renderAttendee person =
    li [ class <| makeElement "attendee-wrapper" ]
        [ div [ class Bem.Common.media ]
            [ img
                [ classList
                    [ ( makeElement "avatar", True )
                    , ( Bem.Common.mediaFigure, True )
                    ]
                , src person.avatarUrl
                ]
                []
            , div [ class Bem.Common.mediaBody ]
                [ h3 [ class <| makeElement "name" ] [ text person.name ]
                , gitHubUsername person.gitHubUsername
                ]
            ]
        , questionAnswer WhatDidIDoYesterday person
        , questionAnswer WhatWillIDoToday person
        , questionAnswer WhatIsBlockingMe person
        , questionAnswer CanIConnectWith person
        ]


gitHubUsername : String -> Html Msg
gitHubUsername username =
    span
        [ class <| makeElement "github-username" ]
        [ text <| "@" ++ username ]


questionAnswer : Question -> Person -> Html Msg
questionAnswer question person =
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
                , ( Bem.Common.media, True )
                ]
            ]
            [ h4
                [ classList
                    [ ( Bem.Common.mediaFigure, True )
                    , ( makeElement "question-title", True )
                    ]
                ]
                [ text title ]
            , textarea [ class Bem.Common.mediaBody ] []
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
