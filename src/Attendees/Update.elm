module Attendees.Update exposing (update)

import Attendees.Model exposing (Attendee)
import Attendees.Messages exposing (Msg(..), Question(..))


update : Msg -> List Attendee -> ( List Attendee, Cmd Msg )
update msg attendees =
    case msg of
        Update personId question answer ->
            let
                updateAttendee attendee =
                    if attendee.person.id == personId then
                        case question of
                            WhatDidIDoYesterday ->
                                { attendee | didYesterday = answer }

                            WhatWillIDoToday ->
                                { attendee | willDoToday = answer }

                            WhatIsBlockingMe ->
                                { attendee | blockers = answer }

                            CanIConnectWith ->
                                { attendee | connects = answer }
                    else
                        attendee
            in
                ( List.map updateAttendee attendees, Cmd.none )

        _ ->
            ( attendees, Cmd.none )
