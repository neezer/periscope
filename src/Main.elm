module Main exposing (..)

import Html exposing (Html, div, button, text, h1)
import Date exposing (Date)
import Date.Extra
import Task


type alias Model =
    { date : Maybe Date
    }


type Msg
    = NoOp
    | RequestDate
    | ReceiveDate Date


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text (getFormattedDate model.date)
            ]
        ]


init : ( Model, Cmd Msg )
init =
    ( { date = Nothing }, getCurrentDate )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestDate ->
            ( model, getCurrentDate )

        ReceiveDate date ->
            let
                nextModel =
                    { model | date = Just date }
            in
                ( nextModel, Cmd.none )

        _ ->
            ( model, Cmd.none )


getCurrentDate : Cmd Msg
getCurrentDate =
    Task.perform ReceiveDate Date.now


getFormattedDate : Maybe Date -> String
getFormattedDate date =
    case date of
        Just d ->
            Date.Extra.toFormattedString "EEEE MMMM d, y" d

        Nothing ->
            ""
