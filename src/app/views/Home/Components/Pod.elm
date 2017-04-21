module Home.Components.Pod exposing (..)

import Constants exposing (Msg, Msg(UpdateServiceFilter))
import Home.Styles as CSS
import Html exposing (Attribute, Html, div, img, input, text)
import Html.CssHelpers
import Service exposing (Service)
import Shared.Styles as SharedCSS exposing (sharedNamespace)


{ class } =
    Html.CssHelpers.withNamespace "dashboard"


renderPod : Service -> Html Msg
renderPod item =
    div
        [ class [ CSS.Pod ]
        , if item.error > 0 then
            class [ CSS.PodError ]
          else if item.warning > 0 then
            class [ CSS.PodWarning ]
          else
            class [ CSS.PodHealthy ]
        ]
        [ div [ class [ CSS.PodName ] ]
            [ text item.name ]
        , div [ class [ CSS.StatusIndicators ] ]
            [ if item.healthy > 0 then
                div [ class [ CSS.StatusIndicator, CSS.StatusIndicatorHealthy ], sharedNamespace.class [ SharedCSS.Antialiased ] ] [ item.healthy |> toString |> text ]
              else
                div [] []
            , if item.warning > 0 then
                div
                    [ class
                        [ CSS.StatusIndicator
                        , CSS.StatusIndicatorWarning
                        ]
                    , sharedNamespace.class
                        [ SharedCSS.Antialiased
                        ]
                    , if item.error == 0 then
                        class [ CSS.StatusIndicatorWarningActive ]
                      else
                        class [ CSS.NoStyle ]
                    ]
                    [ item.warning |> toString |> text ]
              else
                div [] []
            , if item.error > 0 then
                div
                    [ class
                        [ CSS.StatusIndicator
                        , CSS.StatusIndicatorError
                        ]
                    , sharedNamespace.class
                        [ SharedCSS.Antialiased
                        ]
                    , if item.error == 0 then
                        class [ CSS.StatusIndicatorWarningActive ]
                      else
                        class [ CSS.NoStyle ]
                    ]
                    [ item.error |> toString |> text ]
              else
                div [] []
            ]
        ]
