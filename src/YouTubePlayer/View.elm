module YouTubePlayer.View exposing (root)

import Main.Types exposing (Video, Msg(..))
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


root : Video -> Html Msg
root video =
    div [ class block ]
        [ player video
        , urlInput video.id
        ]


player : Video -> Html Msg
player video =
    let
        id =
            video.id

        isEditing =
            video.editing
    in
        case ( id, isEditing ) of
            ( Just id, False ) ->
                iframe
                    [ width 631
                    , height 355
                    , src <| "https://www.youtube.com/embed/" ++ id
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
            , onInput UpdateVideo
            , onEnter LoadVideo
            , class <| makeElement "url-input"
            , value <| getYouTubeVideoId youTubeVideoId
            ]
            []
        , button
            [ onClick ClearVideo
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
