module Subscription exposing (..)

import Action exposing (Msg)
import Model exposing (Model)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
