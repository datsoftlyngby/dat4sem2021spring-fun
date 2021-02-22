module Main exposing (..)

import Browser
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)

main = Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Pet =
    { id: Int
    , name: String
    , age: Int
    , alive: Bool
    }

init : Pet
init = Pet 7 "Ninus" 9 True

-- UPDATE

type Message
    = CelebratePet
    | KillPet

update : Message -> Pet -> Pet
update message pet =
    case message of
        CelebratePet ->
            { pet | age = (pet.age + 1) }
        KillPet ->
            { pet | alive = False }

-- VIEW
view : Pet -> Html Message
view pet =
    div [ style "color" "red"] [ text pet.name ]

-- <div style="color: red">Ninus</div>