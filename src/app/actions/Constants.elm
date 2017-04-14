module Constants exposing (..)

import Service exposing (ServiceResponse)
import Time exposing (Time)


type Msg
    = ReceiveQueryResponse ServiceResponse
    | UpdateServiceFilter String
    | Poll Time
