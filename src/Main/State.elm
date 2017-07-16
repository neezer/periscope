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
                newUid =
                    model.uid + 1

                newAnnouncement =
                    { id = newUid
                    , text = ""
                    , editing = True
                    }

                oldAnnouncements =
                    model.announcements
                        |> List.filter (\m -> not <| String.isEmpty m.text)
                        |> List.map (\m -> { m | editing = False })

                newAnnouncements =
                    oldAnnouncements ++ [ newAnnouncement ]

                newModel =
                    { model | announcements = newAnnouncements, uid = newUid }
            in
                ( newModel, Cmd.none )

        FinishEditingAnnouncement ->
            let
                newAnnouncements =
                    model.announcements
                        |> List.filter (\m -> not <| String.isEmpty m.text)
                        |> List.map (\m -> { m | editing = False })

                newModel =
                    { model | announcements = newAnnouncements }
            in
                ( newModel, Cmd.none )

        UpdateAnnouncement id text ->
            let
                updateAnnouncement a =
                    if a.id == id then
                        { a | text = text }
                    else
                        a

                newAnnouncements =
                    List.map updateAnnouncement model.announcements

                newModel =
                    { model | announcements = newAnnouncements }
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
            , uid = 0
            }
    in
        ( initialModel, getCurrentDate )


getCurrentDate : Cmd Msg
getCurrentDate =
    Task.perform ReceiveDate Date.now
