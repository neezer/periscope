module Attendees.Model exposing (..)


type alias PersonId =
    Int


type alias Answer =
    String


type alias Person =
    { id : PersonId
    , name : String
    , title : String
    , gitHubUsername : String
    , avatarUrl : String
    }


type alias Attendee =
    { person : Person
    , didYesterday : Answer
    , willDoToday : Answer
    , blockers : Answer
    , connects : Answer
    }


type alias Model =
    { records : List Attendee
    }
