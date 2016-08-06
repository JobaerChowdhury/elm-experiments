module Main exposing (..)

import Html exposing (Html, div, text)
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
    Time


getTime : Cmd Msg
getTime =
    Time.now |> Task.perform (\x -> NoOp) Tick


init : ( Model, Cmd Msg )
init =
    ( 0, getTime )



-- UPDATE


type Msg
    = NoOp
    | Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( newTime, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS
--subscriptions : Model -> Sub Msg
--subscriptions model =
--Time.every second Tick


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text "Current time is: "
        , text (toString model)
        ]
