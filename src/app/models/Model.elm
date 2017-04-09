module Model exposing (..)

import Podlist exposing (PodlistResponse)


type alias Model =
    { message : String
    , logo : String
    , pods : Maybe PodlistResponse
    }
