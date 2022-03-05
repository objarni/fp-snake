module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Coord = {x: Int, y: Int}

type alias Model = 
  { count: Int
  , head: Coord
  , bodyParts: List Coord
  }

init : Model
init =
  { count=0
  , head={x=10, y=10}
  , bodyParts=[{x=8, y=10}, {x=9, y=10}]
  }

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      {model | count=model.count + 2}

    Decrement ->
      {model | count=model.count - 1}


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
      ]
    ([ drawHead model.head] ++ List.map (viewCell "white") model.bodyParts )
