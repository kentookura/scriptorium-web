module Uni.Course exposing (Course, Msg(..), main, update, view)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = lg, update = update, view = view }


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


type alias Course =
    { name : String
    , teacher : Name
    , semester : String
    , ects : ECTS
    , language : Language
    , description : CourseDescription
    }


cga : Course
cga =
    { name = "Cohomology of Groups and Algebras"
    , teacher = "Dietrich Burde"
    , semester = "WS2022"
    , ects = 5
    , language = English
    , description = { information = "asdf", literature = [ "asdf", "asdf" ] }
    }


lg : Course
lg =
    { name = "Lie Groups"
    , teacher = "Andreas Cap"
    , semester = "WS2022"
    , ects = 5
    , language = English
    , description = { information = "asdf", literature = [ "asdf", "asdf" ] }
    }


update : Msg -> Course -> Course
update msg course =
    course



--view : Model -> Html Msg
--view model =
--    div []
--        [ button [ onClick Decrement ] [ text "-" ]
--        , div [] [ text (String.fromInt model) ]
--        , button [ onClick Increment ] [ text "+" ]
--        ]


type Msg
    = Int


view : Course -> Html Msg
view course =
    div []
        [ div
            []
            [ h3 []
                [ text course.name
                ]
            ]
        , div []
            [ text course.teacher
            ]
        ]
