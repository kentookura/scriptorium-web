module Notes.Markdown exposing (main)

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


markdownInputView : String -> Html Msg
markdownInputView markdownInput =
    Html.textarea
        [ Attr.value markdownInput
        , Html.Events.onInput OnMarkdownInput
        , Attr.style "width" "100%"
        , Attr.style "height" "500px"
        , Attr.style "font-size" "18px"
        ]
        []


deadEndsToString deadEnds =
    deadEnds
        |> List.map Markdown.deadEndToString
        |> String.join "\n"


markdownBody =
    """
# 1 Esse intrata referre inter adspeximus aequora soror

3 Iamque insula, ore longe dixerat libratum neque terrarum resedit de iuranda cum
muneris *tamen*, suas populique te. Alumno invidiae cecinit exarsit modo vidit
ingentia suum, et pluribus sensu *Danais* adigitque acervo gravis visae,
capillos!

"""


type Msg
    = OnMarkdownInput String


type alias Flags =
    ()


type alias Model =
    String


main : Platform.Program Flags Model Msg
main =
    Browser.document
        { init = \flags -> ( markdownBody, Cmd.none )
        , view = \model -> { body = [ view model ], title = "Markdown Example" }
        , update = update
        , subscriptions = \model -> Sub.none
        }


update msg model =
    case msg of
        OnMarkdownInput newMarkdown ->
            ( newMarkdown, Cmd.none )
