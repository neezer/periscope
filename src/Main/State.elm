module Main.State exposing (update, init)

import Main.Types exposing (Model, Announcement, Msg(..))
import Date exposing (Date)
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestDate ->
            ( model, getCurrentDate )

        ReceiveDate date ->
            ( { model | date = Just date }, Cmd.none )

        UpdateVideo youTubeVideoId ->
            let
                video =
                    model.inspirationalVideo

                newVideo =
                    { video | id = Just youTubeVideoId, editing = True }

                newModel =
                    { model | inspirationalVideo = newVideo }
            in
                ( newModel, Cmd.none )

        LoadVideo ->
            let
                video =
                    model.inspirationalVideo

                newVideo =
                    { video | editing = False }

                newModel =
                    { model | inspirationalVideo = newVideo }
            in
                ( newModel, Cmd.none )

        ClearVideo ->
            let
                video =
                    model.inspirationalVideo

                newVideo =
                    { video | id = Nothing }

                newModel =
                    { model | inspirationalVideo = newVideo }
            in
                ( newModel, Cmd.none )

        AddAnnouncement ->
            let
                newAnnouncement =
                    Announcement "" True

                announcements =
                    model.announcements ++ [ newAnnouncement ]

                newModel =
                    { model | announcements = announcements }
            in
                ( newModel, Cmd.none )

        _ ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    let
        initialModel =
            { date = Nothing
            , inspirationalVideo =
                { id = Nothing
                , editing = False
                }
            , announcements = []
            }
    in
        ( initialModel, getCurrentDate )


getCurrentDate : Cmd Msg
getCurrentDate =
    Task.perform ReceiveDate Date.now
