module Snake exposing (..)


type alias Snake =
    { direction : Direction
    , head : Coordinate
    , body : List Coordinate
    }


type Direction
    = Left
    | Right
    | Up
    | Down


type alias Coordinate =
    { x : Int, y : Int }


snakeStep : Snake -> Snake
snakeStep s = s
