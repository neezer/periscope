module Main exposing (..)

import Main.Model exposing (Model)
import Main.Messages exposing (Msg)
import Main.View
import Main.Update
import Html exposing (Html)


main : Program Never Model Msg
main =
    Html.program
        { init = Main.Update.init
        , view = Main.View.root
        , update = Main.Update.update
        , subscriptions = always Sub.none
        }
