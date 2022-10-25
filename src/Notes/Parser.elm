module Notes.Parser exposing (..)

import Katex as K
    exposing
        ( Latex
        , display
        , human
        , inline
        )
import List
import Parser exposing (..)


type alias Math =
    List Latex


type alias Definition =
    { name : String, definition : Math }


formula : Math
formula =
    [ human "We denote by "
    , inline "\\phi"
    , human " the formula for which "
    , display "\\Gamma \\vDash \\phi"
    ]


raw =
    "We denote by $\\phi$ the formula for which $\\Gamma \\vDash \\phi$"
