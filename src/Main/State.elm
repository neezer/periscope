module Main.State exposing (update, init)

import Main.Types exposing (Model, Msg(..))
import Date exposing (Date)
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestDate ->
            ( model, getCurrentDate )

        ReceiveDate date ->
            ( { model | date = Just date }, Cmd.none )

        UpdateYouTubeVideoId youTubeVideoId ->
            let
                newModel =
                    { model | youTubeVideoId = Just youTubeVideoId, editing = True }
            in
                ( newModel, Cmd.none )

        LoadYouTubeVideo ->
            ( { model | editing = False }, Cmd.none )

        ClearYouTubeVideoId ->
            ( { model | youTubeVideoId = Nothing }, Cmd.none )

        _ ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    let
        initialModel =
            { date = Nothing
            , youTubeVideoId = Nothing
            , editing = False
            }
    in
        ( initialModel, getCurrentDate )


getCurrentDate : Cmd Msg
getCurrentDate =
    Task.perform ReceiveDate Date.now
