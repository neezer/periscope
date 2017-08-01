module Announcements.Update exposing (update)

import Announcements.Messages exposing (Msg(..))
import Announcements.Model exposing (Model, Announcement, AnnouncementsView)
import Dom
import Task


findRecordBy : (a -> Bool) -> List a -> Maybe a
findRecordBy filter records =
    List.head <| List.filter filter records


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Edit recordId ->
            case recordId of
                Just id ->
                    let
                        finder =
                            \r -> r.id == id

                        focusedRecord =
                            findRecordBy finder model.records

                        focus fr =
                            Dom.focus <| "announcement-" ++ toString fr.id
                    in
                        case focusedRecord of
                            Just fr ->
                                ( { model
                                    | view = Announcements.Model.Editing fr
                                  }
                                , Task.attempt (\_ -> NoOp) (focus fr)
                                )

                            Nothing ->
                                ( model, Cmd.none )

                Nothing ->
                    let
                        newUid =
                            model.uid + 1

                        newRecord =
                            Announcement newUid ""

                        oldRecords =
                            getRecordsWithValues model.records

                        newRecords =
                            oldRecords ++ [ newRecord ]

                        newModel =
                            { model
                                | records = newRecords
                                , uid = newUid
                                , view = Announcements.Model.Editing newRecord
                            }
                    in
                        ( newModel, Cmd.none )

        Finish ->
            let
                newRecords =
                    getRecordsWithValues model.records

                view =
                    if List.isEmpty newRecords then
                        Announcements.Model.None
                    else
                        Announcements.Model.List

                newModel =
                    { model | records = newRecords, view = view }
            in
                ( newModel, Cmd.none )

        Update id text ->
            let
                update a =
                    if a.id == id then
                        { a | text = text }
                    else
                        a

                newRecords =
                    List.map update model.records

                newModel =
                    { model | records = newRecords }
            in
                ( newModel, Cmd.none )

        _ ->
            ( model, Cmd.none )


getRecordsWithValues : List Announcement -> List Announcement
getRecordsWithValues records =
    records
        |> List.filter (\m -> not <| String.isEmpty m.text)
