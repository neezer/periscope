module Main.Messages exposing (Msg(..))

import Date exposing (Date)
import Video.Messages
import Main.Types


type Msg
    = NoOp
    | RequestDate
    | ReceiveDate Date
    | VideoMsg Video.Messages.Msg
    | AddAnnouncement
    | FinishEditingAnnouncement
    | UpdateAnnouncement Int String
    | UpdateQuestion Main.Types.Question Main.Types.PersonId String
