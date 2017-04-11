module Service exposing (..)

import GraphQL.Request.Builder exposing (..)
import GraphQL.Client.Http as GraphQLClient


type alias ServiceList =
    { services : List Service
    }


type alias Service =
    { name : String
    , healthy : Int
    , warning : Int
    , error : Int
    }


servicesQuery : Request Query ServiceList
servicesQuery =
    let
        service =
            object Service
                |> with (field "name" [] string)
                |> with (field "healthy" [] int)
                |> with (field "warning" [] int)
                |> with (field "error" [] int)

        serviceList =
            object ServiceList
                |> with (field "services" [] (list service))
    in
        extract
            (field "services" [] serviceList)
            |> queryDocument
            |> request {}


type alias ServiceResponse =
    Result GraphQLClient.Error ServiceList
