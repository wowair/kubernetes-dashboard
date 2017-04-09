module Store exposing (..)

import Action exposing (Msg)
import GraphQL.Client.Http as GraphQLClient
import GraphQL.Request.Builder exposing (Query, Request)
import Model exposing (Model)
import Podlist exposing (podlistQuery)
import Task exposing (Task)


sendQueryRequest : Request Query a -> Task GraphQLClient.Error a
sendQueryRequest request =
    GraphQLClient.sendQuery "http://localhost:4000/graphql" request


sendPodlistQuery : Cmd Msg
sendPodlistQuery =
    sendQueryRequest podlistQuery
        |> Task.attempt Action.ReceiveQueryResponse


init : String -> ( Model, Cmd Msg )
init path =
    ( { message = "Your Elm App is working !", logo = path, pods = Nothing }, sendPodlistQuery )
