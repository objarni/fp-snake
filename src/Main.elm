module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Coord = {x: Int, y: Int}

type alias Model = {
   count: Int,
   head: Coord
 }

init : Model
init =
  { count=0, head={x=10, y=10} }

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      {model | count=model.count + 2}

    Decrement ->
      {model | count=model.count - 1}


view : Model -> Html Msg
view model =
  let 
    drawHead {x, y} = div [
      style "background-color" "orange",
      style "position" "relative",
      style "width" "10px",
      style "height" "10px",
      style "left" ((String.fromInt (10 * x) ++ "px")),
      style "top" ((String.fromInt (10 * y)) ++ "px")
      ] [text " "]
  in
    div [ style "height" "500px"
        , style "width" "500px"
        , style "background-color" "black"
        --, style "position" "relative"
        ]
      [ drawHead model.head ]
