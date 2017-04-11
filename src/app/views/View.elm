module View exposing (..)

import Constants exposing (Msg, Msg(UpdateServiceFilter))
import Fuzzy
import Html exposing (Html, div, img, input, text)
import Html.Attributes exposing (placeholder, src, style)
import Html.Events exposing (onInput)
import Model exposing (Model)
import Service exposing (Service)


view : Model -> Html Msg
view model =
    div [ container ]
        [ div [ content ]
            [ div [ header ]
                [ div [ title ] [ text "Dashboard" ]
                , input [ searchInput, placeholder "Search by service name...", onInput UpdateServiceFilter ] []
                ]
            , div [ pods ]
                (case model.pods of
                    Just response ->
                        (case response of
                            Result.Ok res ->
                                List.map renderPod (List.filter (filterServicesByName model.serviceFilter) res.services)

                            Result.Err _ ->
                                [ div [] [ text "Oh noes! 😰" ] ]
                        )

                    Nothing ->
                        [ div [ loadingMessage ] [ text "👀" ] ]
                )
            ]
        ]


getFuzzyResults : String -> String -> Int
getFuzzyResults query service =
    Fuzzy.match [] [] query service |> .score


filterServicesByName : String -> Service -> Bool
filterServicesByName query service =
    (getFuzzyResults query service.name) < 500


renderPod : Service -> Html Msg
renderPod item =
    div
        [ pod
        , if item.error > 0 then
            pod_error
          else if item.warning > 0 then
            pod_warning
          else
            pod_healthy
        ]
        [ div [ podName, antialiased ]
            [ text item.name ]
        , div [ statusIndicators ]
            [ if item.healthy > 0 then
                div [ statusIndicator, statusIndicator_healthy, antialiased ] [ item.healthy |> toString |> text ]
              else
                div [] []
            , if item.warning > 0 then
                div
                    [ statusIndicator
                    , statusIndicator_warning
                    , antialiased
                    , if item.error == 0 then
                        statusIndicator_warning_active
                      else
                        noStyle
                    ]
                    [ item.warning |> toString |> text ]
              else
                div [] []
            , if item.error > 0 then
                div
                    [ statusIndicator
                    , statusIndicator_error
                    , antialiased
                    , if item.error == 0 then
                        statusIndicator_warning_active
                      else
                        noStyle
                    ]
                    [ item.error |> toString |> text ]
              else
                div [] []
            ]
        ]


container : Html.Attribute msg
container =
    style
        [ ( "padding", "10px" )
        , ( "background-color", "#F9F9F9" )
        , ( "min-height", "100vh" )
        ]


content : Html.Attribute msg
content =
    style
        [ ( "margin", "0 auto" )
        ]


header : Html.Attribute msg
header =
    style
        [ ( "font-size", "40px" )
        , ( "display", "flex" )
        , ( "justify-content", "space-between" )
        , ( "padding", "15px 0" )
        , ( "margin-top", "10px" )
        , ( "border-bottom", "1px solid #EFEFEF" )
        ]


title : Html.Attribute msg
title =
    style [ ( "font-size", "24px" ) ]


searchInput : Html.Attribute msg
searchInput =
    style
        [ ( "flex-basis", "200px" ) ]


pods : Html.Attribute msg
pods =
    style
        [ ( "display", "flex" )
        , ( "flex-wrap", "wrap" )
        , ( "justify-content", "space-between" )
        , ( "padding", "10px 0" )
        ]


pod : Html.Attribute msg
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
        , ( "background-color", "#FFFFFF" )
        ]


pod_healthy : Html.Attribute msg
pod_healthy =
    style []


pod_warning : Html.Attribute msg
pod_warning =
    style
        [ ( "background-color", "#FF9800" )
        , ( "color", "#FFFFFF" )
        ]


pod_error : Html.Attribute msg
pod_error =
    style
        [ ( "background-color", "#F44336" )
        , ( "color", "#FFFFFF" )
        ]


podName : Html.Attribute msg
podName =
    style
        [ ( "display", "flex" )
        , ( "align-items", "center" )
        , ( "font-size", "22px" )
        ]


loadingMessage : Html.Attribute msg
loadingMessage =
    style
        [ ( "display", "flex" )
        , ( "flex", "1" )
        , ( "justify-content", "center" )
        , ( "align-items", "center" )
        , ( "min-height", "100px" )
        ]


statusIndicators : Html.Attribute msg
statusIndicators =
    style
        [ ( "display", "flex" )
        , ( "flex-direction", "row" )
        , ( "justify-content", "flex-end" )
        , ( "align-items", "center" )
        ]


statusIndicator : Html.Attribute msg
statusIndicator =
    style
        [ ( "display", "flex" )
        , ( "justify-content", "center" )
        , ( "align-items", "center" )
        , ( "width", "30px" )
        , ( "height", "30px" )
        , ( "margin", "0 2px" )
        , ( "border-radius", "30px" )
        , ( "font-size", "16px" )
        , ( "font-weight", "700" )
        , ( "color", "#FFFFFF" )
        ]


statusIndicator_healthy : Html.Attribute msg
statusIndicator_healthy =
    style
        [ ( "background-color", "#4CAF50" )
        ]


statusIndicator_warning : Html.Attribute msg
statusIndicator_warning =
    style
        [ ( "background-color", "#FF9800" )
        ]


statusIndicator_warning_active : Html.Attribute msg
statusIndicator_warning_active =
    style
        [ ( "background-color", "#FFFFFF" )
        , ( "color", "#FF9800" )
        ]


statusIndicator_error : Html.Attribute msg
statusIndicator_error =
    style
        [ ( "background-color", "#FFFFFF" )
        , ( "color", "#F44336" )
        ]


antialiased : Html.Attribute msg
antialiased =
    style
        [ ( "-webkit-font-smoothing", "antialiased" )
        , ( "-moz-osx-font-smoothing", "grayscale" )
        ]


noStyle : Html.Attribute msg
noStyle =
    style []
