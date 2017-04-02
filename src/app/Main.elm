module Main exposing (..)

import Action exposing (Msg, update)
import Html exposing (programWithFlags)
import Model exposing (Model)
import Store exposing (init)
import Subscription exposing (subscriptions)
import View exposing (view)


main : Program String Model Msg
main =
    programWithFlags { view = view, init = init, update = update, subscriptions = subscriptions }
