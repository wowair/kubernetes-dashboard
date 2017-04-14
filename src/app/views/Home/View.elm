module Home.View exposing (..)

import Constants exposing (Msg, Msg(UpdateServiceFilter))
import Fuzzy
import Html exposing (Html, div, img, input, text)
import Html.Attributes exposing (placeholder, src, style)
import Html.CssHelpers
import Html.Events exposing (onInput)
import Model exposing (Model)
import Service exposing (Service)
import Home.Styles as CSS
import Home.Components.Pod exposing (renderPod)


{ class } =
    Html.CssHelpers.withNamespace "dashboard"


view : Model -> Html Msg
view model =
    div [ class [ CSS.Container ] ]
        [ div [ class [ CSS.Content ] ]
            [ div [ class [ CSS.Header ] ]
                [ div [ class [ CSS.Title ] ] [ text "Dashboard" ]
                , input [ class [ CSS.SearchInput ], placeholder "Search by service name...", onInput UpdateServiceFilter ] []
                ]
            , div [ class [ CSS.Pods ] ]
                (case model.pods of
                    Just response ->
                        (case response of
                            Result.Ok res ->
                                List.map renderPod (List.filter (filterServicesByName model.serviceFilter) res.services)

                            Result.Err _ ->
                                [ div [] [ text "Oh noes! 😰" ] ]
                        )

                    Nothing ->
                        [ div [ class [ CSS.LoadingMessage ] ] [ text "👀" ] ]
                )
            ]
        ]


getFuzzyResults : String -> String -> Int
getFuzzyResults query service =
    Fuzzy.match [] [] query service |> .score


filterServicesByName : String -> Service -> Bool
filterServicesByName query service =
    (getFuzzyResults query service.name) < 500
