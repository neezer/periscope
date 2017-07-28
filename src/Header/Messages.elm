module Header.Messages exposing (..)

import Date exposing (Date)


type Msg
    = NoOp
    | Request
    | Receive Date
