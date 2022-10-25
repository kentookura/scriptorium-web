module Scriptorium.Route exposing (..)

import Notes.Perspective as Perspective exposing (FQN, PerspectiveParams(..))
import Parser exposing (..)
import Url exposing (Url)


type alias Route =
    String


perspectiveParams : Route -> String
perspectiveParams route =
    case route of
        string ->
            string


type RootPerspective
    = Relative
    | Absolute String


type PerspectiveParams
    = ByRoot RootPerspective
    | ByNamespace RootPerspective FQN


fromUrl : String -> Url -> Route
fromUrl basePath url =
    let
        stripBasePath path =
            if basePath == "/" then
                path

            else
                String.replace basePath "" path

        ensureSlashPrefix path =
            if String.startsWith "/" path then
                path

            else
                "/" ++ path

        parse url_ =
            Result.withDefault (Perspective (ByRoot Perspective.Relative)) (Parser.run toRoute url_)
    in
    url
        |> .path
        |> stripBasePath
        |> ensureSlashPrefix
        |> parse
