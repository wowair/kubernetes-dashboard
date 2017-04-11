module ServiceQuery exposing (..)

import SendQueryRequest exposing (sendQueryRequest)
import Constants exposing (Msg)
import Service exposing (servicesQuery)
import Task exposing (Task)


sendServiceQuery : Cmd Msg
sendServiceQuery =
    sendQueryRequest servicesQuery
        |> Task.attempt Constants.ReceiveQueryResponse
