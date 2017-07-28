module Main.Messages exposing (Msg(..))

import Video.Messages
import Header.Messages
import Announcements.Messages
import Attendees.Messages


type Msg
    = NoOp
    | HeaderMsg Header.Messages.Msg
    | VideoMsg Video.Messages.Msg
    | AnnouncementsMsg Announcements.Messages.Msg
    | AttendeesMsg Attendees.Messages.Msg
