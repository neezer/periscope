module Announcements.Update exposing (update)

import Announcements.Messages exposing (Msg(..))
import Announcements.Model exposing (Model, Announcement)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Add ->
            let
                newUid =
                    model.uid + 1

                newRecord =
                    Announcement newUid "" True

                oldRecords =
                    getRecordsWithValues model.records

                newRecords =
                    oldRecords ++ [ newRecord ]

                newModel =
                    { model | records = newRecords, uid = newUid }
            in
                ( newModel, Cmd.none )

        FinishEditing ->
            let
                newRecords =
                    getRecordsWithValues model.records

                newModel =
                    { model | records = newRecords }
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
        |> List.map (\m -> { m | editing = False })
