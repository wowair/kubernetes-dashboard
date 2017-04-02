module Store exposing (..)

import Action exposing (Msg)
import Model exposing (Model)


init : String -> ( Model, Cmd Msg )
init path =
    ( { message = "Your Elm App is working !", logo = path }, Cmd.none )
