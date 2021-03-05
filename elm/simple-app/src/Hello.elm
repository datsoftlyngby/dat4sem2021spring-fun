module Hello exposing (..)

import Browser

import Html exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, field, int, map2, map3, map4, string)

-- main : Program flags ...
main = Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

type alias Greeter =
    { name: String
    , greeting: String
    , age: Int
    , address: Address
    }

type alias Address =
    { street: String
    , city: String
    }

type Model
  = Failure String
  | Waiting
  | Loading
  | Succes Greeter

type Message
  = TryAgainPlease
  | GreetingResult (Result Http.Error Greeter)

init : () -> (Model, Cmd Message)
init _ = (Waiting, Cmd.none)


update : Message -> Model -> (Model, Cmd Message)
update message model =
    case message of
        TryAgainPlease ->
            (Loading, getGreeting)

        GreetingResult result ->
            case result of
                Ok greeting -> (Succes greeting, Cmd.none)
                Err error ->
                  case error of
                    Http.BadStatus code ->
                      (Failure ("Code: "++(String.fromInt code)), Cmd.none)
                    Http.NetworkError ->
                      (Failure "Network Error", Cmd.none)
                    Http.BadBody err ->
                      (Failure err, Cmd.none)
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
    , expect = Http.expectJson GreetingResult greeterDecoder
    }

addressDecoder: Decoder Address
addressDecoder =
    map2 Address
        (field "street" string)
        (field "city" string)

greeterDecoder : Decoder Greeter
greeterDecoder =
    map4 Greeter
        (field "name" string)
        (field "greeting" string)
        (field "age" int)
        (field "address" addressDecoder)



view : Model -> Html Message
view model =
    case model of
        Waiting -> button [ onClick TryAgainPlease ] [ text "Click for greeting"]
        Failure msg -> text ("Something went wrong: "++msg)
        Loading -> text "... please wait ..."
        Succes greeter ->
            div []
                [ text ("The greeting from "++greeter.name++" who is "++(String.fromInt greeter.age)++" years old, was: "++greeter.greeting)
                , text ("it lives at "++greeter.address.street++" in "++greeter.address.city)
                , button [ onClick TryAgainPlease ] [ text "Click for new greeting" ]
                ]


subscriptions : Model -> Sub Message
subscriptions _ = Sub.none