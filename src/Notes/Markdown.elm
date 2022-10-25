module Notes.Markdown exposing (..)

import Browser
import Css exposing (..)
import Html exposing (Attribute, Html, div, text)
import Html.Attributes as Attr
import Html.Events
import Markdown.Parser as Markdown
import Markdown.Renderer


view : String -> Html Msg
view markdownInput =
    Html.div [ Attr.style "padding" "20px" ]
        [ case
            markdownInput
                |> Markdown.parse
                |> Result.mapError deadEndsToString
                |> Result.andThen (\ast -> Markdown.Renderer.render Markdown.Renderer.defaultHtmlRenderer ast)
          of
            Ok rendered ->
                div [] rendered

            Err errors ->
                text errors
        ]


deadEndsToString deadEnds =
    deadEnds
        |> List.map Markdown.deadEndToString
        |> String.join "\n"


markdownBody =
    """
## Ziele, Inhalte und Methode der Lehrver
Die Grundlagen der numerischen Analysis werden behandelt, insbesondere Kondition von Problemen, Stabilität von Algorithmen und Konvergenz von numerischen Verfahren.
Die folgenden Probleme werden behandelt: lineare und nichtlineare Gleichungssystemen, Optimierungsprobleme, Interpolation, Eigenwertprobleme, Differentiation und Integration.
Wir implementieren die Algorithmen in der Programmiersprache Julia.

## Art der Leistungskontrolle und erlaubte Hilfsmittel

schriftliche oder mündliche Prüfungen

## Mindestanforderungen und Beurteilungsmaßstab

Für eine positive Prüfungsbewertung sind mindestens 50% der erreichbaren Punkte zu erzielen.

## Prüfungsstoff

Gesamter Stoff der Vorlesung.

## Literatur

- Trefethen, Bau: Numerical Linear Algebra, SIAM, 1997.
- Deuflhard, Hohmann: Numerische Mathematik 1, De Gruyter, 2019.
- Bourgeois, M.: Grundlagen der Numerischen Mathematik und des Wissenschaftlichen Rechnens, Teubner, 2002.

"""


type Msg
    = OnMarkdownInput String


type alias Flags =
    ()


type alias Model =
    String


main : Platform.Program Flags Model Msg
main =
    Browser.element
        { init = \flags -> ( markdownBody, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }


update msg model =
    case msg of
        OnMarkdownInput newMarkdown ->
            ( newMarkdown, Cmd.none )
