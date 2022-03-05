module Main exposing (..)

import Browser
import Browser.Dom as Dom
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, tabindex, id)
import Keyboard exposing (Key(..))
import Keyboard.Events as Keyboard
import Task

main =
  Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

type alias Flags = {}

type alias Coord = {x: Int, y: Int}

type alias Model = 
  { count: Int
  , head: Coord
  , bodyParts: List Coord
  }

type Msg = Increment | Decrement | NoOp


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : Flags -> (Model, Cmd Msg)
init flags = ({ count=0
  , head={x=10, y=10}
  , bodyParts=[{x=8, y=10}, {x=9, y=10}]
  }, Dom.focus "app-div" |> Task.attempt (always NoOp) )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      ({ model
      | count=model.count + 2
      , head={x=model.head.x+1,y=model.head.y}
      }, Cmd.none)

    Decrement ->
      ({model | count=model.count - 1}, Cmd.none)

    NoOp -> (model, Cmd.none)


viewCell color {x, y} = div [
  style "background-color" color,
  style "position" "absolute",
  style "width" "10px",
  style "height" "10px",
  style "left" ((String.fromInt (10 * x) ++ "px")),
  style "top" ((String.fromInt (10 * y)) ++ "px")
  ] [text " "]


drawHead coord = viewCell "orange" coord


view : Model -> Html Msg
view model =
  div [ style "height" "500px"
      , style "width" "500px"
      , style "background-color" "black"
      , style "position" "relative"
      , tabindex 0
      , id "app-div"
      , Keyboard.on Keyboard.Keydown [(Escape, Increment)]
      ]
    ([ drawHead model.head] ++ List.map (viewCell "white") model.bodyParts )
