module Podlist exposing (..)

import GraphQL.Request.Builder exposing (..)
import GraphQL.Client.Http as GraphQLClient


type alias Podlist =
    { items : List PodItem
    }


type alias PodItem =
    { status : PodItemStatus
    , spec : PodItemSpec
    }


type alias PodItemSpec =
    { containers : List PodItemContainer
    }


type alias PodItemContainer =
    { name : String
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

        container_ =
            object PodItemContainer |> with (field "name" [] string)

        podItemSpec =
            object PodItemSpec
                |> with (field "containers" [] (list container_))

        podItem =
            object PodItem
                |> with (field "status" [] podItemStatus)
                |> with (field "spec" [] podItemSpec)

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
