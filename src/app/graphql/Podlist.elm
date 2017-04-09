module Podlist exposing (..)

import GraphQL.Request.Builder exposing (..)
import GraphQL.Client.Http as GraphQLClient


type alias Podlist =
    { items : List PodItem
    }


type alias PodItem =
    { status : PodItemStatus
    }


type alias PodItemStatus =
    { containerStatuses : List ContainerStatus
    }


type alias ContainerStatus =
    { name : String
    , state : ContainerState
    }


type alias ContainerState =
    { running : ContainerStateRunning
    }


type alias ContainerStateRunning =
    { startedAt : String
    }


podlistQuery : Request Query Podlist
podlistQuery =
    let
        containerStateRunning =
            object ContainerStateRunning
                |> with (field "startedAt" [] string)

        containerState =
            object ContainerState
                |> with (field "running" [] containerStateRunning)

        containerStatuses =
            object ContainerStatus
                |> with (field "name" [] string)
                |> with (field "state" [] containerState)

        podItemStatus =
            object PodItemStatus
                |> with (field "containerStatuses" [] (list containerStatuses))

        podItem =
            object PodItem
                |> with (field "status" [] (podItemStatus))

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
