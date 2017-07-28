module Main.Messages exposing (Msg(..))

import Video.Messages
import Header.Messages
import Announcements.Messages
import Main.Types


type Msg
    = NoOp
    | HeaderMsg Header.Messages.Msg
    | VideoMsg Video.Messages.Msg
    | AnnouncementsMsg Announcements.Messages.Msg
    | UpdateQuestion Main.Types.Question Main.Types.PersonId String
