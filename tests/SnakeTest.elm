module SnakeTest exposing (..)

import Expect
import Snake exposing (Direction(..), snakeStep)
import Test exposing (..)


suite : Test
suite =
    describe "Tests"
        [ describe "Basic list operations"
            [ test "drop works as I expect" <|
                \_ ->
                    let
                        ls =
                            [ 1, 2, 3 ]
                    in
                    Expect.equal [ 3 ] (List.drop 2 ls)
            , test "take works as I expect" <|
                \_ ->
                    let
                        ls =
                            [ 1, 2, 3 ]
                    in
                    Expect.equal [ 1, 2 ] (List.take 2 ls)
            ]
        , describe "Snake Behaviour"
            [ test "2 cell snake test one step right" <|
                \_ ->
                    let
                        snakeBefore =
                            { heading = Right
                            , head = { x = 1, y = 2 }
                            , body = [ { x = 0, y = 2 } ]
                            }

                        expected =
                            { heading = Right
                            , head = { x = 2, y = 2 }
                            , body = [ { x = 1, y = 2 } ]
                            }
                    in
                    Expect.equal expected (snakeStep snakeBefore { x = 0, y = 0 })
            , test "2 cell snake test one step down" <|
                \_ ->
                    let
                        snakeBefore =
                            { heading = Down
                            , head = { x = 1, y = 2 }
                            , body = [ { x = 0, y = 2 } ]
                            }

                        expected =
                            { heading = Down
                            , head = { x = 1, y = 3 }
                            , body = [ { x = 1, y = 2 } ]
                            }
                    in
                    Expect.equal expected (snakeStep snakeBefore { x = 0, y = 0 })
            , test "3 cell snake test one step up" <|
                \_ ->
                    let
                        snakeBefore =
                            { heading = Up
                            , head = { x = 3, y = 2 }
                            , body = [ { x = 2, y = 2 }, { x = 1, y = 2 } ]
                            }

                        expected =
                            { heading = Up
                            , head = { x = 3, y = 1 }
                            , body = [ { x = 3, y = 2 }, { x = 2, y = 2 } ]
                            }
                    in
                    Expect.equal expected (snakeStep snakeBefore { x = 0, y = 0 })
            , test "the head of body is neighbour of snake head" <|
                \_ ->
                    let
                        snakeBefore =
                            { heading = Left
                            , head = { x = 1, y = 0 }
                            , body = [ { x = 2, y = 0 }, { x = 3, y = 0 } ]
                            }

                        expected =
                            { heading = Left
                            , head = { x = 0, y = 0 }
                            , body = [ { x = 1, y = 0 }, { x = 2, y = 0 } ]
                            }
                    in
                    Expect.equal expected (snakeStep snakeBefore { x = 100, y = 100 })
            -- TODO: test is hard to express/get right. Rewrite this test as a printer/approval style?
            -- - Tried this, but I don't know how to write multi line strings in Elm!
            , test "eating a munchie means 3 more body cells at end" <|
               \_ ->
                   let
                       munchiePosition =
                           { x = 3, y = 1 }
            
                       snakeBefore =
                           { heading = Up
                           , head = { x = 3, y = 2 }
                           , body =
                               [ { x = 2, y = 2 }
                               , { x = 1, y = 2 }
                               ]
                           }
            
                       expected =
                           { heading = Up
                           , head = munchiePosition
                           , body =
                               [ { x = 3, y = 2 }
                               , { x = 2, y = 2 }
                               , { x = 2, y = 2 }
                               , { x = 2, y = 2 }
                               , { x = 2, y = 2 }
                               ]
                           }
                   in
                   Expect.equal expected (snakeStep snakeBefore munchiePosition)
            ]
        ]
