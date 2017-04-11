module Model exposing (..)

import Service exposing (ServiceResponse)


type alias Model =
    { message : String
    , logo : String
    , pods : Maybe ServiceResponse
    }
