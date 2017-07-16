module Main.Types exposing (Model, Msg(..))

import Date exposing (Date)
import YouTubePlayer.Types exposing (YouTubeVideoId)


type alias Model =
    { date : Maybe Date
    , youTubeVideoId : Maybe YouTubeVideoId
    , editing : Bool
    }


type Msg
    = NoOp
    | RequestDate
    | ReceiveDate Date
    | UpdateYouTubeVideoId YouTubeVideoId
    | LoadYouTubeVideo
    | ClearYouTubeVideoId
