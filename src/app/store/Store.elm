module Store exposing (..)

import Constants exposing (Msg)
import Model exposing (Model)
import ServiceQuery exposing (sendServiceQuery)


init : ( Model, Cmd Msg )
init =
    ( { pods = Nothing
      , serviceFilter = ""
      }
    , sendServiceQuery
    )
