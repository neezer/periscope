module Announcements.Model
    exposing
        ( Model
        , Announcement
        , AnnouncementsView(..)
        )


type alias Model =
    { uid : Int
    , records : List Announcement
    , view : AnnouncementsView
    }


type alias Announcement =
    { id : Int
    , text : String
    }


type AnnouncementsView
    = None
    | List
    | Editing Announcement
