module Shared.Styles exposing (..)

import Css exposing (..)
import Html.CssHelpers


type CssClasses
    = Antialiased
    | Header


sharedNamespace =
    Html.CssHelpers.withNamespace "shared"


css : Stylesheet
css =
    stylesheet
        [ class Antialiased
            [ property "-webkit-font-smoothing" "antialiased"
            , property "-moz-osx-font-smoothing" "grayscale"
            ]
        ]
