module Main.Types
    exposing
        ( Model
        , Video
        , Attendee
        , Announcement
        , Person
        , Question(..)
        , Msg(..)
        )

import Date exposing (Date)
import YouTubePlayer.Types exposing (YouTubeVideoId)


type alias PersonId =
    Int


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
    { id : Int
    , text : String
    , editing : Bool
    }


type alias Person =
    { id : PersonId
    , name : String
    , title : String
    , gitHubUsername : String
    , avatarUrl : String
    }


type alias Attendee =
    { person : Person
    , didYesterday : String
    , willDoToday : String
    , blockers : String
    , connects : String
    }


type Question
    = WhatDidIDoYesterday
    | WhatWillIDoToday
    | WhatIsBlockingMe
    | CanIConnectWith


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
    | UpdateQuestion Question PersonId String
