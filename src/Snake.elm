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
            move heading head
    in
    { heading = heading
    , head = newHead
    , body = [ head ]
    }


move : Direction -> Coordinate -> Coordinate
move dir { x, y } =
    case dir of
        Left ->
            { x = x - 1, y = y }

        Right ->
            { x = x + 1, y = y }

        Up ->
            { x = x, y = y - 1 }

        Down ->
            { x = x, y = y + 1 }
