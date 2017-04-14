module Home.Styles exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Shared.Styles as SharedCSS


type PodClasses
    = Container
    | Content
    | Header
    | Title
    | SearchInput
    | Pods
    | Pod
    | PodHealthy
    | PodWarning
    | PodError
    | PodName
    | LoadingMessage
    | StatusIndicators
    | StatusIndicator
    | StatusIndicatorHealthy
    | StatusIndicatorWarning
    | StatusIndicatorWarningActive
    | StatusIndicatorError
    | NoStyle


css : Stylesheet
css =
    (stylesheet << namespace "dashboard")
        [ class Container
            [ padding (px 10)
            , backgroundColor (hex "F9F9F9")
            , minHeight (vh 100)
            ]
        , class Content
            [ margin2 (px 0) (auto) ]
        , class Header
            [ fontSize (px 40)
            , displayFlex
            , justifyContent spaceBetween
            , padding2 (px 15) (px 0)
            , marginTop (px 10)
            , borderBottom3 (px 1) solid (hex "EFEFEF")
            ]
        , class Title
            [ fontSize (px 24) ]
        , class SearchInput
            [ flexBasis (px 200) ]
        , class Pods
            [ displayFlex
            , flexWrap wrap
            , justifyContent spaceBetween
            , padding2 (px 10) (px 0)
            ]
        , class Pod
            [ displayFlex
            , justifyContent spaceBetween
            , flexGrow (int 1)
            , width (px 350)
            , padding (px 20)
            , margin (px 5)
            , border3 (px 1) solid (hex "EFEFEF")
            , borderRadius (px 4)
            , boxShadow4 (px 0) (px 2) (px 2) (Css.rgba 0 0 0 0.02)
            , textAlign left
            , backgroundColor (hex "FFFFFF")
            ]
        , class PodHealthy
            []
        , class PodWarning
            [ backgroundColor (hex "FF9800")
            , color (hex "FFFFFF")
            ]
        , class PodError
            [ backgroundColor (hex "F44336")
            , color (hex "FFFFFF")
            ]
        , class PodName
            [ displayFlex
            , alignItems center
            , fontSize (px 22)
            ]
        , class LoadingMessage
            [ displayFlex
            , flex (int 1)
            , justifyContent center
            , alignItems center
            , minHeight (px 100)
            ]
        , class StatusIndicators
            [ displayFlex
            , flexDirection row
            , justifyContent flexEnd
            , alignItems center
            ]
        , class StatusIndicator
            [ displayFlex
            , justifyContent center
            , alignItems center
            , width (px 30)
            , height (px 30)
            , margin2 (px 0) (px 2)
            , borderRadius (px 30)
            , fontSize (px 16)
            , fontWeight (int 700)
            , color (hex "FFFFFF")
            ]
        , class StatusIndicatorHealthy
            [ backgroundColor (hex "4CAF50") ]
        , class StatusIndicatorWarning
            [ backgroundColor (hex "FF9800") ]
        , class StatusIndicatorWarningActive
            [ backgroundColor (hex "FFFFFF")
            , color (hex "FF9800")
            ]
        , class StatusIndicatorError
            [ backgroundColor (hex "FFFFFF")
            , color (hex "F44336")
            ]
        , class NoStyle
            []
        ]
