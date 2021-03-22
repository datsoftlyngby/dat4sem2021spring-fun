module MenuPage exposing (..)

import Html exposing (..)
import MessageMPSPA exposing (Message)

type alias MenuModel =
    { message : String
    }

update : Message -> MenuModel -> MenuModel
update message model = model


view : MenuModel -> Html Message
view model = div [] [ text "This is the menu"]