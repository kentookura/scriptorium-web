module Notes.Perspective exposing (..)

import List.Nonempty as NEL


type FQN
    = FQN (NEL.Nonempty String)


type RootPerspective
    = Relative
    | Absolute String


type PerspectiveParams
    = ByRoot RootPerspective
    | ByNamespace RootPerspective FQN


type
    Perspective
    -- The Root can refer to several things; the root of the codebase,
    -- the root of a project, or a users codebase.
    = Root RootPerspective
    | Namespace
        { root : RootPerspective
        , fqn : FQN
        }
