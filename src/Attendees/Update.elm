module Attendees.Update exposing (update)

import Attendees.Model exposing (Model)
import Attendees.Messages exposing (Msg(..), Question(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
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

                newRecords =
                    List.map updateAttendee model.records

                newModel =
                    { model | records = newRecords }
            in
                ( newModel, Cmd.none )

        _ ->
            ( model, Cmd.none )
