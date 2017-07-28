module Main.Types exposing (Model)

import Video.Model as Video
import Header.Model as Header
import Announcements.Model as Announcements
import Attendees.Model as Attendees


type alias Model =
    { date : Header.Model
    , uid : Int
    , inspirationalVideo : Video.Model
    , announcements : List Announcements.Announcement
    , attendees : List Attendees.Attendee
    }
