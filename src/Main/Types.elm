module Main.Types exposing (Model, Msg(..))

import Date exposing (Date)
import YouTubePlayer.Types exposing (YouTubeUrl)


type alias Model =
    { date : Maybe Date
    , youTubeUrl : Maybe YouTubeUrl
    , editing : Bool
    }


type Msg
    = NoOp
    | RequestDate
    | ReceiveDate Date
    | UpdateYouTubeUrl YouTubeUrl
    | LoadYouTubeUrl
