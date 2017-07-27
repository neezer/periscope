module Video.Update exposing (..)

import Video.Messages exposing (..)
import Video.Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update youTubeVideoId ->
            ( { model | id = Just youTubeVideoId, editing = True }, Cmd.none )

        Load ->
            ( { model | editing = False }, Cmd.none )

        Clear ->
            ( { model | id = Nothing }, Cmd.none )

        _ ->
            ( model, Cmd.none )
