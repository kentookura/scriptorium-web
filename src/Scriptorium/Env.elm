module Scriptorium.Env exposing (..)


type alias Env =
    { basePath : String }


type alias Flags =
    { operatingSystem : String, basePath : String, apiUrl : String }
