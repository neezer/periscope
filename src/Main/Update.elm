module Main.Update exposing (update, init)

import Main.Model exposing (Model)
import Main.Messages exposing (Msg(..))
import Video.Update
import Header.Update
import Announcements.Update
import Attendees.Update
import Video.Model as Video
import Attendees.Model as Attendees
import Announcements.Model as Announcements


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HeaderMsg subMsg ->
            let
                ( newHeaderModel, cmd ) =
                    Header.Update.update subMsg model.date

                newModel =
                    { model | date = newHeaderModel }
            in
                ( newModel, Cmd.map HeaderMsg cmd )

        VideoMsg subMsg ->
            let
                ( newVideoModel, cmd ) =
                    Video.Update.update subMsg model.inspirationalVideo

                newModel =
                    { model | inspirationalVideo = newVideoModel }
            in
                ( newModel, Cmd.map VideoMsg cmd )

        AnnouncementsMsg subMsg ->
            let
                ( newAnnouncements, cmd ) =
                    Announcements.Update.update subMsg model.announcements

                newModel =
                    { model | announcements = newAnnouncements }
            in
                ( newModel, Cmd.map AnnouncementsMsg cmd )

        AttendeesMsg subMsg ->
            let
                ( newAttendees, cmd ) =
                    Attendees.Update.update subMsg model.attendees

                newModel =
                    { model | attendees = newAttendees }
            in
                ( newModel, Cmd.map AttendeesMsg cmd )

        _ ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    let
        initialModel =
            { date = Nothing
            , inspirationalVideo = Video.Model Nothing False
            , announcements =
                Announcements.Model 0 [] Announcements.None
            , attendees =
                Attendees.Model []
            }
    in
        ( initialModel
        , Cmd.batch
            [ Cmd.map HeaderMsg Header.Update.getCurrentDate
            ]
        )



-- evan : Attendees.Person
-- evan =
--     Attendees.Person 1 "Evan" "Team Lead" "neezer" "https://avatars6.githubusercontent.com/u/29997?v=4&s=460"
-- tim : Attendees.Person
-- tim =
--     Attendees.Person 2 "Tim" "Developer" "beardedtim" "https://avatars7.githubusercontent.com/u/8563579?v=4&s=460"
-- joey : Attendees.Person
-- joey =
--     Attendees.Person 3 "Joey" "Developer" "jgbenito7" "https://avatars5.githubusercontent.com/u/6375353?v=4&s=460"
-- blair : Attendees.Person
-- blair =
--     Attendees.Person 4 "Blair" "Developer" "zhaolwu" "https://avatars5.githubusercontent.com/u/29712873?v=4&s=460"
-- bogdan : Attendees.Person
-- bogdan =
--     Attendees.Person 5 "Bogdan" "Developer" "blobor" "https://avatars7.githubusercontent.com/u/4813007?v=4&s=460"
-- roksolana : Attendees.Person
-- roksolana =
--     Attendees.Person 6 "Roksolana" "Developer" "lianapache" "https://avatars4.githubusercontent.com/u/12541467?v=4&s=460"
