module Podlist exposing (..)

import GraphQL.Request.Builder exposing (..)
import GraphQL.Client.Http as GraphQLClient


type alias Podlist =
    { items : List PodItem
    }


type alias PodItem =
    { spec : PodItemSpec
    }


type alias PodItemSpec =
    { containers : List Container
    }


type alias Container =
    { name : String
    }


podlistQuery : Request Query Podlist
podlistQuery =
    let
        container =
            object Container
                |> with (field "name" [] string)

        podItemSpec =
            object PodItemSpec
                |> with (field "containers" [] (list container))

        podItem =
            object PodItem
                |> with (field "spec" [] (podItemSpec))

        podlist =
            object Podlist
                |> with (field "items" [] (list podItem))
    in
        extract
            (field "pods"
                []
                (podlist)
            )
            |> queryDocument
            |> request {}


type alias PodlistResponse =
    Result GraphQLClient.Error Podlist
