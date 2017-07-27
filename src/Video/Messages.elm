module Video.Messages exposing (..)

import Video.Model


type Msg
    = NoOp
    | Update Video.Model.YouTubeVideoId
    | Load
    | Clear
