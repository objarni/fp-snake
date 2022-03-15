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


boxSize =
    50


snakeStep : Snake -> Coordinate -> Snake
snakeStep { heading, head, body } munchieAt =
    let
        newHead =
            move heading head

        bodyLength =
            List.length body

        tailCell =
            List.drop (bodyLength - 2) body |> List.head |> Maybe.withDefault {x=0, y=0}

        bodyWithoutTailCell =
            List.take (bodyLength - 1) body

        newBody = head :: bodyWithoutTailCell
        additionalExtra = if newHead == munchieAt then [tailCell, tailCell, tailCell] else []
    in
    { heading = heading
    , head = newHead
    , body = newBody ++ additionalExtra
    }


snakeInBox : Snake -> Bool
snakeInBox snake =
    let
        xInside =
            0 <= snake.head.x && (snake.head.x < boxSize)
    in
    xInside


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
