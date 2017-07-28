module Attendees.Messages exposing (..)

import Attendees.Model exposing (PersonId, Answer)


type Msg
    = NoOp
    | Update PersonId Question Answer


type Question
    = WhatDidIDoYesterday
    | WhatWillIDoToday
    | WhatIsBlockingMe
    | CanIConnectWith
