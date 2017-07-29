module Announcements.Model exposing (Model, Announcement)


type alias Model =
    { uid : Int
    , records : List Announcement
    }


type alias Announcement =
    { id : Int
    , text : String
    , editing : Bool
    }
