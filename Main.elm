module Main exposing (..)

import Html exposing (Html, div, text, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Time exposing (Time, second)
import Task exposing (perform)


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    State


type State
    = Running Time
    | Resumed
    | Paused


getTime : Cmd Msg
getTime =
    Time.now |> Task.perform (\x -> NoOp) Tick


init : ( Model, Cmd Msg )
init =
    ( Running 0, getTime )



-- UPDATE


type Msg
    = NoOp
    | Pause
    | Resume
    | Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( Running newTime, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

        Pause ->
            ( Paused, Cmd.none )

        Resume ->
            ( Resumed, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        Paused ->
            Sub.none

        _ ->
            Time.every second Tick



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text "Current time is: "
        , text (toString model)
        , showButton model
        ]


showButton : Model -> Html Msg
showButton model =
    case model of
        Paused ->
            button [ type' "button", onClick Resume ] [ text "Resume" ]

        _ ->
            button [ type' "button", onClick Pause ] [ text "Pause" ]
