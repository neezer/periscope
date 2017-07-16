module Main.Types
    exposing
        ( Model
        , Video
        , Announcement
        , Person
        , Msg(..)
        )

import Date exposing (Date)
import YouTubePlayer.Types exposing (YouTubeVideoId)


type alias Model =
    { date : Maybe Date
    , uid : Int
    , inspirationalVideo : Video
    , announcements : List Announcement
    , attendees : List Person
    }


type alias Video =
    { id : Maybe YouTubeVideoId
    , editing : Bool
    }


type alias Announcement =
    { id : Int
    , text : String
    , editing : Bool
    }


type alias Person =
    { id : Int
    , name : String
    , title : String
    , gitHubUsername : String
    , avatarUrl : String
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
