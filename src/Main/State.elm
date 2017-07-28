module Main.State exposing (update, init)

import Main.Types
    exposing
        ( Model
        , Attendee
        , Person
        , Question(..)
        )
import Main.Messages exposing (Msg(..))
import Video.Update
import Header.Update
import Video.Model as Video
import List


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

        UpdateQuestion question personId text ->
            let
                updateAttendee attendee =
                    if attendee.person.id == personId then
                        case question of
                            WhatDidIDoYesterday ->
                                { attendee | didYesterday = text }

                            WhatWillIDoToday ->
                                { attendee | willDoToday = text }

                            WhatIsBlockingMe ->
                                { attendee | blockers = text }

                            CanIConnectWith ->
                                { attendee | connects = text }
                    else
                        attendee

                newAttendees =
                    List.map updateAttendee model.attendees

                newModel =
                    { model | attendees = newAttendees }
            in
                ( newModel, Cmd.none )

        _ ->
            ( model, Cmd.none )


init : ( Model, Cmd Msg )
init =
    let
        initialModel =
            { date = Nothing
            , inspirationalVideo = Video.Model Nothing False
            , announcements = []
            , attendees =
                [ Attendee evan "" "" "" ""
                , Attendee bogdan "" "" "" ""
                , Attendee tim "" "" "" ""
                , Attendee joey "" "" "" ""
                , Attendee blair "" "" "" ""
                , Attendee roksolana "" "" "" ""
                ]
            , uid = 0
            }
    in
        ( initialModel, Cmd.map HeaderMsg Header.Update.getCurrentDate )


evan : Person
evan =
    Person 1 "Evan" "Team Lead" "neezer" "https://avatars6.githubusercontent.com/u/29997?v=4&s=460"


tim : Person
tim =
    Person 2 "Tim" "Developer" "beardedtim" "https://avatars7.githubusercontent.com/u/8563579?v=4&s=460"


joey : Person
joey =
    Person 3 "Joey" "Developer" "jgbenito7" "https://avatars5.githubusercontent.com/u/6375353?v=4&s=460"


blair : Person
blair =
    Person 4 "Blair" "Developer" "zhaolwu" "https://avatars5.githubusercontent.com/u/29712873?v=4&s=460"


bogdan : Person
bogdan =
    Person 5 "Bogdan" "Developer" "blobor" "https://avatars7.githubusercontent.com/u/4813007?v=4&s=460"


roksolana : Person
roksolana =
    Person 6 "Roksolana" "Developer" "lianapache" "https://avatars4.githubusercontent.com/u/12541467?v=4&s=460"
