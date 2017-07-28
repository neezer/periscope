module Announcements.Update exposing (update)

import Announcements.Messages exposing (Msg(..))
import Announcements.Model exposing (Model)


    | Add
    | FinishEditing
    | Update Int String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add ->
            ( model, getCurrentDate )

        FinishEditing ->
            ( Just date, Cmd.none )

        _ ->
            ( model, Cmd.none )
