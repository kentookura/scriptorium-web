module Scriptorium.App exposing (..)

import Browser
import Browser.Navigation as Nav


type alias Model =
    { route : Route }


type alias Env =
    { basePath : String
    }


init : Env -> Route -> ( Model, Cmd Msg )
init env route =
    let
        model =
            { route = route }
    in
    ( model, Cmd.none )


type Route
    = Route


type Msg
    = NewNote
    | ShowFinder


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ route } as model) =
    case msg of
        NewNote ->
            ( model, Cmd.none )

        ShowFinder ->
            ( model, Cmd.none )
