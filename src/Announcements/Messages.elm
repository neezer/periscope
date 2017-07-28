module Announcements.Messages exposing (Msg(..))


type Msg
    = NoOp
    | Add
    | FinishEditing
    | Update Int String
