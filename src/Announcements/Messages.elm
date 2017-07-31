module Announcements.Messages exposing (Msg(..))


type Msg
    = NoOp
    | Edit (Maybe Int)
    | Finish
    | Update Int String
