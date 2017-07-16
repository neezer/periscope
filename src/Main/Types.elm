module Main.Types exposing (Model, Video, Announcement, Msg(..))

import Date exposing (Date)
import YouTubePlayer.Types exposing (YouTubeVideoId)


type alias Model =
    { date : Maybe Date
    , uid : Int
    , inspirationalVideo : Video
    , announcements : List Announcement
    }


type alias Video =
    { id : Maybe YouTubeVideoId
    , editing : Bool
    }


type alias Announcement =
    { text : String
    , editing : Bool
    , id : Int
    }


type Msg
    = NoOp
    | RequestDate
    | ReceiveDate Date
    | UpdateVideo YouTubeVideoId
    | LoadVideo
    | ClearVideo
    | AddAnnouncement
    | FinishEditingAnnouncement
    | UpdateAnnouncement Int String
