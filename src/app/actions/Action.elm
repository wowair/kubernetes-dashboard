module Action exposing (..)

import Constants exposing (..)
import Model exposing (Model)
import ServiceQuery exposing (sendServiceQuery)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveQueryResponse response ->
            ( { model | pods = Just response }, Cmd.none )

        UpdateServiceFilter string ->
            ( { model | serviceFilter = string }, Cmd.none )

        Poll _ ->
            ( model, sendServiceQuery )
