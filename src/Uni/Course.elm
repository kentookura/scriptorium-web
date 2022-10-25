module Uni.Course exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Notes.Markdown exposing (..)


type alias Book =
    String


type alias Name =
    String


type alias Title =
    String


type alias Teacher =
    String


type alias ECTS =
    Int


type Language
    = English
    | German


type alias CourseDescription =
    { information : String
    , literature : List Book
    }


type alias Metadata =
    { name : String
    , teacher : Name
    , semester : String
    , ects : ECTS
    , language : Language
    , description : CourseDescription
    }


type alias Model =
    { info : Metadata, schedule : List String }


data =
    [ cga, lg ]


cga : Metadata
cga =
    { name = "Cohomology of Groups and Algebras"
    , teacher = "Dietrich Burde"
    , semester = "WS2022"
    , ects = 5
    , language = English
    , description = { information = "asdf", literature = [ "asdf", "asdf" ] }
    }


lg : Metadata
lg =
    { name = "Lie Groups"
    , teacher = "Andreas Cap"
    , semester = "WS2022"
    , ects = 5
    , language = English
    , description = { information = "asdf", literature = [ "asdf", "asdf" ] }
    }


update : Msg -> Model -> ( Model, Cmd msg )
update msg course =
    case msg of
        _ ->
            ( course, Cmd.none )


type Msg
    = Int


view : Model -> Html Msg
view model =
    div []
        [ div
            []
            [ h3 []
                [ text model.info.name
                ]
            ]
        , div []
            [ text model.info.teacher

            --, viewMarkdown model.description.information
            ]
        ]


testData : Model
testData =
    { info = lg, schedule = [ "lec 1", "lec 1" ] }


init : () -> ( Model, Cmd Msg )
init _ =
    ( testData, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
