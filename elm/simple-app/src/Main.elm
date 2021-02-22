module Main exposing (..)

import Browser
import Html exposing (Html, button, div, input, li, span, text, ul)
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

type alias Model =
    { pets: List Pet }

init : Model
init = Model
    [ Pet 7 "Ninus" 9 True
    , Pet 9 "Rufus" 3 True
    , Pet 13 "Felix" 5 True
    ]

-- UPDATE

type Message
    = CelebratePet Int
    | KillPet
    | NameChanged String

getPet : Int -> List Pet -> Maybe Pet
getPet id pets =
    case pets of
        [] -> Nothing
        pet :: rest -> if pet.id == id then Just pet else (getPet id rest)

setPet : Pet -> List Pet -> List Pet
setPet pet pets =
    case pets of
        [] -> [pet]
        p :: rest -> if pet.id == p.id then pet :: rest else p :: (setPet pet rest)

update : Message -> Model -> Model
update message model =
    case message of
        CelebratePet id ->
            let
                maybePet = getPet id model.pets
            in
                case maybePet of
                    Just pet ->
                        let
                            updatedPet = { pet | age = pet.age + 1 }
                        in
                            { model | pets = (setPet updatedPet model.pets) }
                    Nothing ->
                        model
            -- { pet | age = (pet.age + 1) }
        _ -> model
{-
        KillPet ->
            { pet | alive = False }
        NameChanged newName ->
            { pet | name = newName }
-}

-- VIEW

view : Model -> Html Message
view model =
    div [ style "margin" "2em" ]
        [ ul [] (List.map viewPet model.pets)
        ]

viewPet : Pet -> Html Message
viewPet pet =
    li []
        [ span [ style "marginRight" "1ex"] [ text (String.fromInt pet.id) ]
        , input [ onInput NameChanged,  value pet.name ] []
        , span
            [ style "color" (if pet.alive then "green" else "red") ]
            [ text (" is "++(String.fromInt pet.age)++" years old") ]
        , button [ onClick (CelebratePet pet.id)] [ text "Celebrate" ]
        , button [ onClick KillPet ] [text "Kill" ]
        ]

--    div [ style "color" "red"] [ text ("Min kanin hedder "++pet.name) ]

-- <div style="color: red">Ninus</div>
-- <button onclick="...">Celebrate</button>