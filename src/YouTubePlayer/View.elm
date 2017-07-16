module YouTubePlayer.View exposing (root)

import Main.Types exposing (Model, Msg(..))
import Html exposing (Html, Attribute, text, h1, div, input, iframe, form)
import Html.Events exposing (on, keyCode, onInput)
import Html.Attributes exposing (class, placeholder, width, height, src, property)
import Json.Encode
import Json.Decode


root : Model -> Html Msg
root model =
    div [ class "youtube-inspiration" ]
        [ player model
        , urlInput
        ]


player : Model -> Html Msg
player model =
    let
        youTubeUrl =
            model.youTubeUrl
    in
        case ( youTubeUrl, model.editing ) of
            ( Just youTubeUrl, False ) ->
                iframe
                    [ width 584
                    , height 329
                    , src youTubeUrl
                    , property "frameborder" (Json.Encode.string "0")
                    , property "allowFullscreen" (Json.Encode.string "true")
                    ]
                    []

            ( _, _ ) ->
                text ""


urlInput : Html Msg
urlInput =
    input
        [ placeholder "(Enter a YouTube embed URL and hit <Enter>)"
        , onInput UpdateYouTubeUrl
        , onEnter LoadYouTubeUrl
        ]
        []


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.Decode.succeed msg
            else
                Json.Decode.fail "not ENTER"
    in
        on "keydown" (Json.Decode.andThen isEnter keyCode)
