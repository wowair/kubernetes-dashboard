module Main exposing (..)

import Action exposing (update)
import Constants exposing (Msg)
import Html exposing (program)
import Model exposing (Model)
import Store exposing (init)
import Subscription exposing (subscriptions)
import View exposing (view)


main : Program Never Model Msg
main =
    program { view = view, init = init, update = update, subscriptions = subscriptions }
