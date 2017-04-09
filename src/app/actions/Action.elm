module Action exposing (..)

import Model exposing (Model)
import Podlist exposing (PodlistResponse)


type Msg
    = NoOp
    | ReceiveQueryResponse PodlistResponse


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ReceiveQueryResponse response ->
            ( { model | pods = Just response }, Cmd.none )
