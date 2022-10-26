module Uni.Course exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Markdown.Parser as Markdown
import Markdown.Renderer
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


type alias Course =
    { name : String
    , teacher : Name
    , semester : String
    , ects : ECTS
    , language : Language
    , description : String
    , literature : List Book
    , schedule : List String
    }


update : Msg -> Course -> ( Course, Cmd msg )
update msg courses =
    case msg of
        _ ->
            ( courses, Cmd.none )


type Msg
    = Int


view : Course -> Html a
view course =
    div
        []
        [ div
            []
            [ h3 []
                [ text course.name
                ]
            ]
        , div
            [ style "border-radius" "5px"
            , style "background-color" "#f6edd9"
            , style "padding" "20px"
            ]
            [ text course.teacher
            , case
                course.description
                    |> Markdown.parse
                    |> Result.mapError deadEndsToString
                    |> Result.andThen (\ast -> Markdown.Renderer.render Markdown.Renderer.defaultHtmlRenderer ast)
              of
                Ok rendered ->
                    div [] rendered

                Err errors ->
                    text errors
            ]
        ]


init : () -> ( Course, Cmd Msg )
init _ =
    ( lg, Cmd.none )


subscriptions : Course -> Sub Msg
subscriptions courses =
    Sub.none


main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


data =
    [ cga, lg ]


cga : Course
cga =
    { name = "Cohomology of Groups and Algebras"
    , teacher = "Dietrich Burde"
    , semester = "WS2022"
    , ects = 5
    , language = English
    , description = "asdf"
    , literature = []
    , schedule = []
    }


lg : Course
lg =
    { name = "Lie Groups"
    , teacher = "Andreas Cap"
    , semester = "WS2022"
    , ects = 5
    , language = English
    , literature =
        [ "Brickell, Clark, Differentiable manifolds"
        , "Cap, Lie Groups"
        , "Chevalley, Theory of Lie groups"
        , "Duistermaat, Kolk, Lie groups"
        , "Hilgert, Neeb, Lie Gruppen und Lie Algebren"
        , "Lee, Manifolds and differential geometry"
        , "Michor, Topics in differential geometry"
        ]
    , description =
        "## Ziele, Inhalte und Methode der Lehrveranstaltung\nThis lecture course serves as a first introduction to the theory of Lie groups. The focus will be on the interrelation between Lie groups and their Lie algebras. Among others, the following topics will be treated: topological properties, matrix groups, exponential map, Lie subgroups, homomorphisms, the Frobenius theorem, group actions, classification of Lie groups, representation theory of compact Lie groups. The lecture will be based on this script: https://www.mat.univie.ac.at/~mike/teaching/ws1920/lg.pdf\n## Art der Leistungskontrolle und erlaubte Hilfsmittel\nOral exam.\n\n## Mindestanforderungen und Beurteilungsmaßstab\nWorking knowledge of course material.\n\n## Prüfungsstoff\n\nContent of the lecture.n"
    , schedule = []
    }
