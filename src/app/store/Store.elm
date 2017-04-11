module Store exposing (..)

import Action exposing (Msg)
import GraphQL.Client.Http as GraphQLClient
import GraphQL.Request.Builder exposing (Query, Request)
import Model exposing (Model)
import Service exposing (servicesQuery)
import Task exposing (Task)


sendQueryRequest : Request Query a -> Task GraphQLClient.Error a
sendQueryRequest request =
    GraphQLClient.sendQuery "http://localhost:4000/graphql" request


sendServiceQuery : Cmd Msg
sendServiceQuery =
    sendQueryRequest servicesQuery
        |> Task.attempt Action.ReceiveQueryResponse


init : ( Model, Cmd Msg )
init =
    ( { pods = Nothing }, sendServiceQuery )
