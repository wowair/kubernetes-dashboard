module View exposing (..)

import Action exposing (Msg)
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (src)
import Model exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ img [ src model.logo ] []
        , div [] [ text model.message ]
        ]
