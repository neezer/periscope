module Header.Update exposing (update, getCurrentDate)

import Header.Messages exposing (Msg(..))
import Header.Model exposing (Model)
import Date
import Task


getCurrentDate : Cmd Msg
getCurrentDate =
    Task.perform Receive Date.now


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Request ->
            ( model, getCurrentDate )

        Receive date ->
            ( Just date, Cmd.none )

        _ ->
            ( model, Cmd.none )
