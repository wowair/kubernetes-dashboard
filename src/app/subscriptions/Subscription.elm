module Subscription exposing (..)

import Constants exposing (..)
import Model exposing (Model)
import Time exposing (second)


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (2 * second) Poll
