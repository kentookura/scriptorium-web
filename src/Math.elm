module Math exposing (view)

import Browser
import Html as H exposing (Html)
import Katex as K exposing (Latex)
import Notes.Parser exposing (..)
import Parser exposing (..)


main =
    view formula


view : List Latex -> Html msg
view tex =
    let
        htmlGenerator isDisplayMode stringLatex =
            case isDisplayMode of
                Just True ->
                    H.div [] [ H.text stringLatex ]

                _ ->
                    H.span [] [ H.text stringLatex ]
    in
    tex
        |> List.map (K.generate htmlGenerator)
        |> H.div []
