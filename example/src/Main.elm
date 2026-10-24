module Main exposing (Model, Msg(..), main, view)

import Browser as B
import Html as H exposing (Html)
import Html.Events as HE


main : Program () Model Msg
main =
    B.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view : Model -> Html Msg
view model =
    H.div []
        [ H.button [ HE.onClick Decrement ] [ H.text "-" ]
        , H.div [] [ H.text (String.fromInt model) ]
        , H.button [ HE.onClick Increment ] [ H.text "+" ]
        ]
