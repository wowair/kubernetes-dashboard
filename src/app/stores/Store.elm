module Store exposing (..)

import Action exposing (Msg)


type alias Model =
    { message : String
    , logo : String
    }


init : String -> ( Model, Cmd Msg )
init path =
    ( { message = "Your Elm App is working !", logo = path }, Cmd.none )
