module Hello exposing (..)

import Browser

import Html exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode

-- main : Program flags ...
main = Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

type alias Greeting =
    { name: String
    , greeting: String
    }

type Model
  = Failure String
  | Waiting
  | Loading
  | Succes String

type Message
  = TryAgainPlease
  | GreetingResult (Result Http.Error String)

init : () -> (Model, Cmd Message)
init _ = (Waiting, Cmd.none)


update : Message -> Model -> (Model, Cmd Message)
update message model =
    case message of
        TryAgainPlease ->
            (Loading, getGreeting)

        GreetingResult result ->
            case result of
                Ok greetingText -> (Succes greetingText, Cmd.none)
                Err error ->
                  case error of
                    Http.BadStatus code ->
                      (Failure ("Code: "++(String.fromInt code)), Cmd.none)
                    Http.NetworkError ->
                      (Failure "Network Error", Cmd.none)
                    _ ->
                        (Failure "Unknown", Cmd.none)


{-
type Error
    = BadUrl String
    | Timeout
    | NetworkError
    | BadStatus Int
    | BadBody String

-}
getGreeting : Cmd Message
getGreeting = Http.get
    { url = "http://localhost:4711/"
    , expect = Http.expectJson GreetingResult greetingDecoder
    }

greetingDecoder : Json.Decode.Decoder String
greetingDecoder =
    Json.Decode.field "name" Json.Decode.string



view : Model -> Html Message
view model =
    case model of
        Waiting -> button [ onClick TryAgainPlease ] [ text "Click for greeting"]
        Failure msg -> text ("Something went wrong: "++msg)
        Loading -> text "... please wait ..."
        Succes greeting ->
            div []
                [ text ("The greeting was: "++greeting)
                , button [ onClick TryAgainPlease ] [ text "Click for new greeting" ]
                ]


subscriptions : Model -> Sub Message
subscriptions _ = Sub.none