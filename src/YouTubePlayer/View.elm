module YouTubePlayer.View exposing (root)

import Main.Types exposing (Model, Msg(..))
import Html
    exposing
        ( Html
        , Attribute
        , div
        , iframe
        , span
        , text
        , input
        , button
        )
import Bem
import Bem.Types
import YouTubePlayer.Types exposing (YouTubeVideoId)
import Html.Events exposing (on, keyCode, onInput, onClick)
import Html.Attributes
    exposing
        ( class
        , placeholder
        , width
        , height
        , src
        , property
        , value
        )
import Json.Encode
import Json.Decode


block : Bem.Types.Block
block =
    Bem.makeBlock
        "youtube-inspiration"


makeElement : String -> Bem.Types.Element
makeElement =
    Bem.makeElement block


root : Model -> Html Msg
root model =
    div [ class block ]
        [ player model
        , urlInput model.youTubeVideoId
        ]


player : Model -> Html Msg
player model =
    let
        youTubeVideoId =
            model.youTubeVideoId
    in
        case ( youTubeVideoId, model.editing ) of
            ( Just youTubeVideoId, False ) ->
                iframe
                    [ width 584
                    , height 329
                    , src <| "https://www.youtube.com/embed/" ++ youTubeVideoId
                    , property "frameborder" <| Json.Encode.string "0"
                    , property "allowFullscreen" <| Json.Encode.string "true"
                    ]
                    []

            ( _, _ ) ->
                text ""


urlInput : Maybe YouTubeVideoId -> Html Msg
urlInput youTubeVideoId =
    div [ class <| makeElement "url-input-wrapper" ]
        [ span
            [ class <| makeElement "url-input-label" ]
            [ text "YouTube Video ID:" ]
        , input
            [ placeholder "Enter a YouTube video ID and hit <Enter>"
            , onInput UpdateYouTubeVideoId
            , onEnter LoadYouTubeVideo
            , class <| makeElement "url-input"
            , value <| getYouTubeVideoId youTubeVideoId
            ]
            []
        , button
            [ onClick ClearYouTubeVideoId
            , class <| makeElement "url-input-clear"
            ]
            [ text "clear" ]
        ]


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


getYouTubeVideoId : Maybe YouTubeVideoId -> String
getYouTubeVideoId youTubeVideoId =
    case youTubeVideoId of
        Just id ->
            id

        Nothing ->
            ""
