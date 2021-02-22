module Main exposing (..)

import Browser
import Html exposing (Html, button, div, input, span, text)
import Html.Attributes exposing (style, value)
import Html.Events exposing (onClick, onInput)

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
    | NameChanged String

update : Message -> Pet -> Pet
update message pet =
    case message of
        CelebratePet ->
            { pet | age = (pet.age + 1) }
        KillPet ->
            { pet | alive = False }
        NameChanged newName ->
            { pet | name = newName }

-- VIEW

view : Pet -> Html Message
view pet =
    div [ style "margin" "2em" ]
        [ span [ style "marginRight" "1ex"] [ text (String.fromInt pet.id) ]
        , input [ onInput NameChanged,  value pet.name ] []
        , span
            [ style "color" (if pet.alive then "green" else "red") ]
            [ text (" is "++(String.fromInt pet.age)++" years old") ]
        , button [ onClick CelebratePet ] [ text "Celebrate" ]
        , button [ onClick KillPet ] [text "Kill" ]
        ]

--    div [ style "color" "red"] [ text ("Min kanin hedder "++pet.name) ]

-- <div style="color: red">Ninus</div>
-- <button onclick="...">Celebrate</button>