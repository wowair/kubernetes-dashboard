module View exposing (..)

import Constants exposing (Msg, Msg(UpdateServiceFilter))
import Fuzzy
import Html exposing (Html, div, img, input, text)
import Html.Attributes exposing (placeholder, src, style)
import Html.CssHelpers
import Html.Events exposing (onInput)
import Model exposing (Model)
import Service exposing (Service)
import ViewCss exposing (..)


{ class } =
    Html.CssHelpers.withNamespace "dashboard"


view : Model -> Html Msg
view model =
    div [ class [ ViewCss.Container ] ]
        [ div [ class [ ViewCss.Content ] ]
            [ div [ class [ ViewCss.Header ] ]
                [ div [ class [ ViewCss.Title ] ] [ text "Dashboard" ]
                , input [ class [ ViewCss.SearchInput ], placeholder "Search by service name...", onInput UpdateServiceFilter ] []
                ]
            , div [ class [ ViewCss.Pods ] ]
                (case model.pods of
                    Just response ->
                        (case response of
                            Result.Ok res ->
                                List.map renderPod (List.filter (filterServicesByName model.serviceFilter) res.services)

                            Result.Err _ ->
                                [ div [] [ text "Oh noes! 😰" ] ]
                        )

                    Nothing ->
                        [ div [ class [ ViewCss.LoadingMessage ] ] [ text "👀" ] ]
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
        [ class [ ViewCss.Pod ]
        , if item.error > 0 then
            class [ ViewCss.PodError ]
          else if item.warning > 0 then
            class [ ViewCss.PodWarning ]
          else
            class [ ViewCss.PodHealthy ]
        ]
        [ div [ class [ ViewCss.PodName, ViewCss.Antialiased ] ]
            [ text item.name ]
        , div [ class [ ViewCss.StatusIndicators ] ]
            [ if item.healthy > 0 then
                div [ class [ ViewCss.StatusIndicator, ViewCss.StatusIndicatorHealthy, ViewCss.Antialiased ] ] [ item.healthy |> toString |> text ]
              else
                div [] []
            , if item.warning > 0 then
                div
                    [ class
                        [ ViewCss.StatusIndicator
                        , ViewCss.StatusIndicatorWarning
                        , ViewCss.Antialiased
                        ]
                    , if item.error == 0 then
                        class [ ViewCss.StatusIndicatorWarningActive ]
                      else
                        class [ ViewCss.NoStyle ]
                    ]
                    [ item.warning |> toString |> text ]
              else
                div [] []
            , if item.error > 0 then
                div
                    [ class
                        [ ViewCss.StatusIndicator
                        , ViewCss.StatusIndicatorError
                        , ViewCss.Antialiased
                        ]
                    , if item.error == 0 then
                        class [ ViewCss.StatusIndicatorWarningActive ]
                      else
                        class [ ViewCss.NoStyle ]
                    ]
                    [ item.error |> toString |> text ]
              else
                div [] []
            ]
        ]
