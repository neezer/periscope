module Main.Model exposing (Model)

import Video.Model as Video
import Header.Model as Header
import Announcements.Model as Announcements
import Attendees.Model as Attendees


type alias Model =
    { date : Header.Model
    , inspirationalVideo : Video.Model
    , announcements : Announcements.Model
    , attendees : Attendees.Model
    }
