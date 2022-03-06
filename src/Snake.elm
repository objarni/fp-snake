module Snake exposing (..)


type alias Snake =
    { heading : Direction
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
snakeStep { heading, head, body } =
    let
        newHead =
            { x = head.x + 1, y = head.y }
    in
    { heading = heading
    , head = newHead
    , body = [ head ]
    }
