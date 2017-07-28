module Main.Messages exposing (Msg(..))

import Video.Messages
import Header.Messages
import Main.Types


type Msg
    = NoOp
    | HeaderMsg Header.Messages.Msg
    | VideoMsg Video.Messages.Msg
    | AddAnnouncement
    | FinishEditingAnnouncement
    | UpdateAnnouncement Int String
    | UpdateQuestion Main.Types.Question Main.Types.PersonId String
