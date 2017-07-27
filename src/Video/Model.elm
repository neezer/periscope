module Video.Model exposing (..)


type alias YouTubeVideoId =
    String


type alias Model =
    { id : Maybe YouTubeVideoId
    , editing : Bool
    }



-- different states the video view can be in


type VideoView
    = None
    | New YouTubeVideoId
