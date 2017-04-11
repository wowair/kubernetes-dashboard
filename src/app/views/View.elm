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
        , div [ statusIndicators ]
            [ div [ statusIndicator, statusIndicator_healthy, antialiased ] [ text "3" ]
            , div [ statusIndicator, statusIndicator_warning, antialiased ] [ text "3" ]
            , div [ statusIndicator, statusIndicator_error, antialiased ] [ text "3" ]
            ]
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
        [ ( "display", "flex" )
        , ( "justify-content", "space-between" )
        , ( "flex-grow", "1" )
        , ( "width", "350px" )
        , ( "padding", "20px" )
        , ( "margin", "5px" )
        , ( "border", "1px solid #EFEFEF" )
        , ( "border-radius", "4px" )
        , ( "box-shadow", "0 2px 2px rgba(0,0,0,0.02)" )
        , ( "text-align", "left" )
        ]


pod_warning =
    style
        [ ( "background-color", "#FFC107" )
        , ( "color", "#FFFFFF" )
        ]


pod_error =
    style
        [ ( "background-color", "#F44336" )
        , ( "color", "#FFFFFF" )
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


statusIndicators =
    style
        [ ( "display", "flex" )
        , ( "flex-direction", "row" )
        , ( "justify-content", "flex-end" )
        , ( "align-items", "center" )
        ]


statusIndicator =
    style
        [ ( "display", "flex" )
        , ( "justify-content", "center" )
        , ( "align-items", "center" )
        , ( "width", "24px" )
        , ( "height", "24px" )
        , ( "margin", "0 2px" )
        , ( "border-radius", "24px" )
        , ( "font-size", "12px" )
        , ( "font-weight", "700" )
        , ( "color", "#FFFFFF" )
        ]


statusIndicator_healthy =
    style
        [ ( "background-color", "#4CAF50" )
        ]


statusIndicator_warning =
    style
        [ ( "background-color", "#FFC107" )
        ]


statusIndicator_error =
    style
        [ ( "background-color", "#F44336" )
        ]


antialiased =
    style
        [ ( "-webkit-font-smoothing", "antialiased" )
        , ( "-moz-osx-font-smoothing", "grayscale" )
        ]
