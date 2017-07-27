module Main.Types
    exposing
        ( Model
        , Attendee
        , Announcement
        , Person
        , Question(..)
        , PersonId
        )

import Date exposing (Date)
import Video.Model as Video


type alias PersonId =
    Int


type alias Model =
    { date : Maybe Date
    , uid : Int
    , inspirationalVideo : Video.Model
    , announcements : List Announcement
    , attendees : List Attendee
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
