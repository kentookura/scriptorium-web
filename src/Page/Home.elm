module Page.Home exposing (..)


pageHome : Model -> List (Html Msg)
pageHome model =
    [ Grid.row []
        [ Grid.col []
            [ Card.config [ Card.outlinePrimary ]
                |> Card.headerH4 [] [ text "Getting started" ]
                |> Card.block []
                    [ Block.text [] [ text "Getting started is real easy. Just click the start button." ]
                    , Block.custom <|
                        BButton.linkButton
                            [ BButton.primary, BButton.attrs [ href "#getting-started" ] ]
                            [ text "Start" ]
                    ]
                |> Card.view
            ]
        , Grid.col []
            [ Card.config [ Card.outlineDanger ]
                |> Card.headerH4 [] [ text "Courses" ]
                |> Card.block []
                    [ Block.text [] [ text "Check out the Courses overview" ]
                    , Block.custom <|
                        BButton.linkButton
                            [ BButton.primary, BButton.attrs [ href "#modules" ] ]
                            [ text "Module" ]
                    ]
                |> Card.view
            ]
        ]
    ]
