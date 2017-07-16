module Extra exposing (onEnter)

import Main.Types exposing (Msg)
import Html exposing (Html, Attribute)
import Html.Events exposing (keyCode, on)
import Json.Decode


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.Decode.succeed msg
            else
                Json.Decode.fail "not ENTER"
    in
        on "keydown" <| Json.Decode.andThen isEnter keyCode
