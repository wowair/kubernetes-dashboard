module SendQueryRequest exposing (..)

import GraphQL.Client.Http as GraphQLClient
import GraphQL.Request.Builder exposing (Query, Request)
import Task exposing (Task)


sendQueryRequest : Request Query a -> Task GraphQLClient.Error a
sendQueryRequest request =
    GraphQLClient.sendQuery "http://localhost:4000/graphql" request
