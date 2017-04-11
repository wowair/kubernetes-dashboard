module Action exposing (..)

import Model exposing (Model)
import Service exposing (ServiceResponse)


type Msg
    = NoOp
    | ReceiveQueryResponse ServiceResponse


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ReceiveQueryResponse response ->
            ( { model | pods = Just response }, Cmd.none )
