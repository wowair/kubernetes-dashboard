module Model exposing (..)

import Service exposing (ServiceResponse)


type alias Model =
    { pods : Maybe ServiceResponse
    , serviceFilter : String
    }
