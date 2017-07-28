module Main.Types
    exposing
        ( Model
        , Attendee
        , Person
        , Question(..)
        , PersonId
        )

import Video.Model as Video
import Header.Model as Header
import Announcements.Model as Announcements


type alias PersonId =
    Int


type alias Model =
    { date : Header.Model
    , uid : Int
    , inspirationalVideo : Video.Model
    , announcements : List Announcements.Announcement
    , attendees : List Attendee
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
