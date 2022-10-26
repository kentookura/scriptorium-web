module Main exposing (..)

import Bootstrap.Button as BButton
import Bootstrap.CDN as CDN
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Form.Input as Input
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.ListGroup as Listgroup
import Bootstrap.Modal as Modal
import Bootstrap.Navbar as Navbar
import Bootstrap.Utilities.Spacing as Spacing
import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Maybe.Extra as MaybeE
import UI
import UI.Button as Button exposing (Button)
import UI.Click as Click exposing (Click)
import UI.Icon as Icon exposing (Icon)
import UI.PageContent as PageContent
import UI.PageLayout as PageLayout
import UI.Sidebar as Sidebar exposing (..)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, top)


type alias SidebarMenuItem msg =
    { click : Click msg
    , icon : Icon msg
    , label : String
    , count : Maybe Int
    }


type alias SidebarSection msg =
    { title : String
    , titleButton : Maybe (Button msg)
    , content : List (Html msg)
    , scrollable : Bool
    }


type SidebarContentItem msg
    = MenuItem (SidebarMenuItem msg)
    | Divider
    | Section (SidebarSection msg)


type alias Flags =
    {}


type alias Model =
    { navKey : Navigation.Key
    , page : Page
    , navState : Navbar.State
    , modalVisibility : Modal.Visibility
    , sidebarToggled : Bool
    }


type Page
    = Home
    | Courses
    | Notes
    | NotFound


init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg

        ( model, urlCmd ) =
            urlUpdate url { navKey = key, navState = navState, page = Home, modalVisibility = Modal.hidden, sidebarToggled = True }
    in
    ( model, Cmd.batch [ urlCmd, navCmd ] )


type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State
    | CloseModal
    | ToggleSidebar
    | ShowModal


subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navState NavMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink req ->
            case req of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.navKey <| Url.toString url )

                Browser.External href ->
                    ( model, Navigation.load href )

        UrlChange url ->
            urlUpdate url model

        NavMsg state ->
            ( { model | navState = state }
            , Cmd.none
            )

        CloseModal ->
            ( { model | modalVisibility = Modal.hidden }
            , Cmd.none
            )

        ShowModal ->
            ( { model | modalVisibility = Modal.shown }
            , Cmd.none
            )

        ToggleSidebar ->
            ( { model | sidebarToggled = not model.sidebarToggled }, Cmd.none )


urlUpdate : Url -> Model -> ( Model, Cmd Msg )
urlUpdate url model =
    case decode url of
        Nothing ->
            ( { model | page = NotFound }, Cmd.none )

        Just route ->
            ( { model | page = route }, Cmd.none )


decode : Url -> Maybe Page
decode url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> UrlParser.parse routeParser


routeParser : Parser (Page -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home top
        , UrlParser.map Notes (UrlParser.s "notes")
        , UrlParser.map Courses (UrlParser.s "courses")
        ]


view : Model -> Browser.Document Msg
view model =
    let
        page =
            PageLayout.SidebarEdgeToEdgeLayout
                { sidebar = viewMainSidebar model
                , sidebarToggled = model.sidebarToggled
                , content =
                    PageContent.oneColumn
                        [ mainContent model
                        ]
                , footer = PageLayout.PageFooter []
                }
    in
    { title = "Scriptorium Web"
    , body =
        [ div [ id "app" ]
            [ CDN.stylesheet
            , PageLayout.view page
            , sidenav model
            ]
        ]
    }


viewMenuItem : SidebarMenuItem msg -> Html msg
viewMenuItem { click, icon, label, count } =
    let
        count_ =
            case count of
                Just c ->
                    span
                        [ class "sidebar-menu-item-count" ]
                        [ text (String.fromInt c) ]

                Nothing ->
                    UI.nothing
    in
    Click.view [ class "sidebar-menu-item" ]
        [ Icon.view icon, Html.label [] [ text label ], count_ ]
        click


viewSidebarContentItem : SidebarContentItem msg -> Html msg
viewSidebarContentItem item =
    case item of
        MenuItem mi ->
            viewMenuItem mi

        Divider ->
            divider

        Section s ->
            viewSection s


viewSection : SidebarSection msg -> Html msg
viewSection { title, titleButton, content, scrollable } =
    let
        sectionHeader =
            Html.header
                [ class "sidebar-section_header" ]
                [ h3 [ class "sidebar-section_title" ] [ text title ]
                , MaybeE.unwrap UI.nothing Button.view titleButton
                ]
    in
    Html.section
        [ classList
            [ ( "sidebar-section", True )
            , ( "sidebar-section_scrollable", scrollable )
            ]
        ]
        [ sectionHeader
        , div [ class "sidebar-section_content" ] content
        ]


divider : Html msg
divider =
    hr [ class "divider" ] []


viewMainSidebar : Model -> Sidebar.Sidebar Msg
viewMainSidebar model =
    let
        withHeader header s =
            case header of
                Just h ->
                    Sidebar.withHeader h s

                Nothing ->
                    s
    in
    Sidebar.empty "main-sidebar"
        |> Sidebar.withToggle { isToggled = model.sidebarToggled, toggleMsg = ToggleSidebar }


sidenav : Model -> Html Msg
sidenav _ =
    div
        [ class "container-fluid"
        , class "sidebar-sticky"
        ]
        [ Listgroup.ul
            [ Listgroup.li [] [ text "Courses" ]
            , Listgroup.li [] [ text "Notes" ]
            ]
        ]


navbar : Model -> Html Msg
navbar model =
    Navbar.config NavMsg
        |> Navbar.withAnimation
        |> Navbar.collapseMedium
        |> Navbar.info
        |> Navbar.brand
            [ href "#" ]
            [ img
                [ src "assets/images/favicon.svg"
                , class "d-inline-block align-top"
                ]
                []
            , text "Scriptorium Dashboard"
            ]
        |> Navbar.items
            [ Navbar.itemLink [ href "#notes" ] [ text "Notes" ]
            , Navbar.itemLink [ href "#courses" ] [ text "Courses" ]
            ]
        |> Navbar.customItems
            [ Navbar.formItem []
                [ Input.text [ Input.attrs [ placeholder "enter" ] ]
                , BButton.button
                    [ BButton.success
                    , BButton.attrs [ Spacing.ml2Sm ]
                    ]
                    [ text "Search" ]
                ]
            , Navbar.textItem [ Spacing.ml2Sm, class "muted" ] [ text "Text" ]
            ]
        |> Navbar.view model.navState


mainContent : Model -> Html Msg
mainContent model =
    Grid.container [] <|
        case model.page of
            Home ->
                pageHome model

            Courses ->
                pageCourses model

            Notes ->
                pageNotes model

            NotFound ->
                pageNotFound


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


pageNotes : Model -> List (Html Msg)
pageNotes model =
    [ h1 [] [ text "Modules" ]
    , Listgroup.ul
        [ Listgroup.li [] [ text "Alert" ]
        , Listgroup.li [] [ text "Badge" ]
        , Listgroup.li [] [ text "Card" ]
        ]
    ]


pageNotFound : List (Html Msg)
pageNotFound =
    [ h1 [] [ text "Not found" ]
    , text "Sorry couldn't find that page"
    ]


modal : Model -> Html Msg
modal model =
    Modal.config CloseModal
        |> Modal.small
        |> Modal.h4 [] [ text "Getting started ?" ]
        |> Modal.body []
            [ Grid.containerFluid []
                [ Grid.row []
                    [ Grid.col
                        [ Col.xs6 ]
                        [ text "Col 1" ]
                    , Grid.col
                        [ Col.xs6 ]
                        [ text "Col 2" ]
                    ]
                ]
            ]
        |> Modal.view model.modalVisibility
