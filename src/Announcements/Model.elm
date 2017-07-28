module Announcements.Model exposing (Announcement)


type alias Announcement =
    { id : Int
    , text : String
    , editing : Bool
    }
