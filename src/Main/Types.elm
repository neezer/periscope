module Main.Types
    exposing
        ( Model
        , Video
        , Announcement
        , Attendee
        , Msg(..)
        )

import Date exposing (Date)
import YouTubePlayer.Types exposing (YouTubeVideoId)


type alias Model =
    { date : Maybe Date
    , uid : Int
    , inspirationalVideo : Video
    , announcements : List Announcement
    , attendees : List Attendee
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


type alias Attendee =
    { id : Int
    , name : String
    , title : String
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
