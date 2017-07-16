module Main exposing (..)

import Main.Types exposing (Model, Msg(..))
import Main.View
import Main.State
import Html exposing (Html)


main : Program Never Model Msg
main =
    Html.program
        { init = Main.State.init
        , view = Main.View.root
        , update = Main.State.update
        , subscriptions = always Sub.none
        }
