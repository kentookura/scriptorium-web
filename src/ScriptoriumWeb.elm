module ScriptoriumWeb exposing (..)

import Browser
import Scriptorium.App as App
import Scriptorium.Env exposing (Flags)
import Scriptorium.PreApp as PreApp


main : Program Flags PreApp.Model PreApp.Msg
main =
    Browser.application
        { init = PreApp.init
        , update = PreApp.update
        , subscriptions = PreApp.subscriptions
        , onUrlRequest = App.LinkClicked >> PreApp.AppMsg
        , onUrlChange = App.UrlChanged >> PreApp.AppMsg
        }
