module View exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)
import Action exposing (Msg)
import Model exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ img [ src model.logo ] []
        , div [] [ text model.message ]
        ]
