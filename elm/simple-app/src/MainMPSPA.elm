module MainMPSPA exposing (..)

import Browser

import Html exposing (..)
import Html.Events exposing (onClick)
import Http

import MenuPage as Menu exposing (MenuModel)
import ListPage as List exposing (ListModel)
import MessageMPSPA exposing (Message)

main = Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

type MainModel
    = MenuModel MenuModel
    | ListModel ListModel
    | Empty

init : () -> (MainModel, Cmd Message)
init _ = (Empty, Cmd.none)

update : Message -> MainModel -> (MainModel, Cmd Message)
update message model =
    case model of
        MenuModel menu -> (MenuModel (Menu.update message menu), Cmd.none)
        ListModel list -> (ListModel (List.update message list), Cmd.none)
        Empty -> (model, Cmd.none)

view : MainModel -> Html Message
view model =
    case model of
        MenuModel menu -> Menu.view menu
        ListModel list -> List.view list
        Empty -> div [] [ text "No menu yet"]



subscriptions : MainModel -> Sub Message
subscriptions _ = Sub.none

