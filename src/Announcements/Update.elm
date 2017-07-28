module Announcements.Update exposing (update)

import Announcements.Messages exposing (Msg(..))
import Announcements.Model exposing (Announcement)


update : Msg -> List Announcement -> ( List Announcement, Cmd Msg )
update msg model =
    case msg of
        -- TODO restore!!
        _ ->
            ( model, Cmd.none )
