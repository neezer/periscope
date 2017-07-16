module Attendees.View exposing (root)

import Html exposing (Html, div, button, text, h2)
import Html.Attributes exposing (class)
import Main.Types exposing (Attendee, Msg)
import Bem
import Bem.Types


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
        [ h2 [ class <| makeElement "title" ] [ text "Attendees" ]
        , addAttendee
        ]


addAttendee : Html Msg
addAttendee =
    button [] [ text "Add attendee" ]
