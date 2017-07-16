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

        UpdateYouTubeUrl youTubeUrl ->
            let
                newModel =
                    { model | youTubeUrl = Just youTubeUrl, editing = True }
            in
                ( newModel, Cmd.none )

        LoadYouTubeUrl ->
            ( { model | editing = False }, Cmd.none )

        _ ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    let
        initialModel =
            { date = Nothing
            , youTubeUrl = Nothing
            , editing = False
            }
    in
        ( initialModel, getCurrentDate )


getCurrentDate : Cmd Msg
getCurrentDate =
    Task.perform ReceiveDate Date.now
