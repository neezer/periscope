module Video.View exposing (root)

import Video.Messages exposing (Msg)
import Video.Model as Video
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
import Html.Events exposing (onInput, onClick)
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
import Extra exposing (onEnter)
import Json.Encode


block : Bem.Types.Block
block =
    Bem.makeBlock
        "youtube-inspiration"


makeElement : String -> Bem.Types.Element
makeElement =
    Bem.makeElement block


root : Video.Model -> Html Msg
root video =
    div [ class block ]
        [ player video
        , urlInput video.id
        ]


player : Video.Model -> Html Msg
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


urlInput : Maybe Video.YouTubeVideoId -> Html Msg
urlInput youTubeVideoId =
    div [ class <| makeElement "url-input-wrapper" ]
        [ span
            [ class <| makeElement "url-input-label" ]
            [ text "YouTube Video ID:" ]
        , input
            [ placeholder "Enter a YouTube video ID and hit <Enter>"
            , onInput Video.Messages.Update
            , onEnter Video.Messages.Load
            , class <| makeElement "url-input"
            , value <| getYouTubeVideoId youTubeVideoId
            ]
            []
        , button
            [ onClick Video.Messages.Clear
            , class <| makeElement "url-input-clear"
            ]
            [ text "clear" ]
        ]


getYouTubeVideoId : Maybe Video.YouTubeVideoId -> String
getYouTubeVideoId youTubeVideoId =
    case youTubeVideoId of
        Just id ->
            id

        Nothing ->
            ""
