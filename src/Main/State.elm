module Main.State exposing (update, init)

import Main.Types exposing (Model, Announcement, Video, Person, Msg(..))
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
                    Announcement newUid "" True

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
            , inspirationalVideo = Video Nothing False
            , announcements = []
            , attendees =
                [ evan
                , bogdan
                , tim
                , joey
                , blair
                , roksolana
                ]
            , uid = 0
            }
    in
        ( initialModel, getCurrentDate )


getCurrentDate : Cmd Msg
getCurrentDate =
    Task.perform ReceiveDate Date.now


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
