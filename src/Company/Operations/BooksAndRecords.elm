module Company.Operations.BooksAndRecords exposing (..)

import Morphir.SDK.StatefulApp exposing (StatefulApp)


type alias ID =
    String


type DealCmd
    = OpenDeal
    | CloseDeal


type alias Deal =
    String


type DealEvent
    = DealOpened ID
    | DealClosed ID
    | DuplicateDeal ID
    | DealDoesNotExist ID


type alias App =
    StatefulApp ID DealCmd Deal DealEvent


app : App
app =
    StatefulApp logic


logic : ID -> Maybe Deal -> DealCmd -> ( ID, Maybe Deal, DealEvent )
logic dealId dealState dealCmd =
    case dealState of
        Just _ ->
            case dealCmd of
                OpenDeal ->
                    ( dealId, dealState, DuplicateDeal dealId )

                CloseDeal ->
                    ( dealId, Nothing, DealClosed dealId )

        Nothing ->
            case dealCmd of
                CloseDeal ->
                    ( dealId, Nothing, DealDoesNotExist dealId )

                OpenDeal ->
                    ( dealId, Just "Amazing deal", DealOpened dealId )
