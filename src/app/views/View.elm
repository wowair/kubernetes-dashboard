module View exposing (..)

import Action exposing (Msg)
import Html exposing (Html, div, img, input, text)
import Html.Attributes exposing (placeholder, src, style)
import Model exposing (Model)


view : Model -> Html Msg
view model =
    div [ container ]
        [ div [ content ]
            [ div [ header ]
                [ div [ title ] [ text "Dashboard" ]
                , input [ searchInput, placeholder "Search by service name" ] []
                ]
            , div [ pods ]
                (case model.pods of
                    Just response ->
                        (case response of
                            Result.Ok res ->
                                List.map renderPod res.items

                            Result.Err _ ->
                                [ div [] [ text "Oh noes! 😰" ] ]
                        )

                    Nothing ->
                        [ div [ loadingMessage ] [ text "👀" ] ]
                )
            ]
        ]


renderPod item =
    div [ pod ]
        [ div [ podName ]
            (case List.head item.spec.containers of
                Just stuff ->
                    [ text stuff.name ]

                Nothing ->
                    [ text "No services found 😿" ]
            )
        ]


container =
    style
        [ ( "padding", "10px" )
        , ( "background-color", "#FEFEFE" )
        ]


content =
    style
        [ ( "margin", "0 auto" )
        ]


header =
    style
        [ ( "font-size", "24px" )
        , ( "display", "flex" )
        , ( "justify-content", "space-between" )
        , ( "padding", "15px 0" )
        , ( "margin-top", "10px" )
        , ( "border-bottom", "1px solid #EFEFEF" )
        ]


title =
    style [ ( "font-size", "24px" ) ]


searchInput =
    style
        [ ( "flex-basis", "200px" ) ]


pods =
    style
        [ ( "display", "flex" )
        , ( "flex-wrap", "wrap" )
        , ( "justify-content", "space-between" )
        , ( "padding", "10px 0" )
        ]


pod =
    style
        [ ( "flex-grow", "1" )
        , ( "width", "350px" )
        , ( "padding", "20px" )
        , ( "margin", "5px" )
        , ( "border", "1px solid #EFEFEF" )
        , ( "border-radius", "4px" )
        , ( "box-shadow", "0 2px 2px rgba(0,0,0,0.02)" )
        , ( "text-align", "left" )
        ]


podName =
    style
        [ ( "font-size", "18px" ) ]


loadingMessage =
    style
        [ ( "display", "flex" )
        , ( "flex", "1" )
        , ( "justify-content", "center" )
        , ( "align-items", "center" )
        , ( "min-height", "100px" )
        ]
