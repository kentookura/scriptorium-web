module Scriptorium.PreApp exposing (..)

import Browser
import Http
import Scriptorium.App as App
import Scriptorium.Env as Env exposing (Flags)
import Scriptorium.Route as Route exposing (PerspectiveParams, Route, perspectiveParams)
import Url exposing (Url)


type Msg
    = AppMsg App.Msg


type Model
    = Initializing PreEnv
    | InitiazionError PreEnv Http.Error
    | Initialized App.Model


type alias PreEnv =
    { flags : Flags, route : Route }


init : Flags -> Url -> ( Model, Cmd Msg )
init flags url =
    let
        route =
            Route.fromUrl flags.basePath url

        preEnv =
            { flags = flags, route = route, perspectiveParams = perspectiveParams route }
    in
    preEnv.perspectiveParams
        |> Perspective.fromParams
        |> perspectiveToAppInit
