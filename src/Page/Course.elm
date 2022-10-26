module Page.Course exposing (..)
import Bootstrap.Button as BButton
import Html exposing (..)


pageCourses : Model -> List (Html Msg)
pageCourses model =
    [ h2 [] [ text "Courses" ]
    , BButton.button
        [ BButton.success
        , BButton.large
        , BButton.block
        , BButton.attrs [ onClick ShowModal ]
        ]
        [ text "Click me" ]
    ]
